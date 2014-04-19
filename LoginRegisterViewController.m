//
//  LoginRegisterViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "LoginRegisterForm.h"
#import "FormValidator.h"
#import "EdibleAlertView.h"
#import "UIViewController+MaryPopin.h"
#import "LoginRegister.h"


#define EmailPlaceHolder @"Email"
#define UserNamePlaceHolder @"Username"
#define PwdPlaceHolder @"Password"



@interface LoginRegisterViewController () <WCActionSheetDelegate,UITextFieldDelegate,NSURLConnectionDataDelegate>
{
    NSMutableData *webdata;
}

@property (nonatomic, strong) LoginRegisterForm *myActionSheet;
@property (nonatomic) BOOL shouldBeginCalledBeforeHand;
@end

@implementation LoginRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //animate label
    [self.AnimatedLabel animateWithWords:@[@"We're the Edible",@"It's the best App",@"Do you like it?"] forDuration:3.0f];
    
    webdata = [[NSMutableData alloc]init];

}

/*****************************************
 
 clicking btns events
 
 ****************************************/

- (IBAction)showLoginForm:(id)sender {
    [self formInitializeAndIfIsLogin:YES];
}

- (IBAction)showRegisterForm:(id)sender {
    [self formInitializeAndIfIsLogin:NO];
}

/*****************************************
 
    initialize based on which form
 
 ****************************************/
-(void) formInitializeAndIfIsLogin:(BOOL) IsLogin{
    
    //you can't refer to self or properties on self from within a block that will be strongly retained by self, so use a weakself
    __weak typeof(self) weakSelf = self;
    
    self.myActionSheet = [[LoginRegisterForm alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    //P.S: you can change placeholder name but can't change componentName (fixed in .m file)
    [self.myActionSheet addTextBoxWithPlaceHolder:@"Email" andComponentName:EmailPlaceHolder];
    
    
    if(IsLogin){//init login form
        [self.myActionSheet addTextBoxWithPlaceHolder:@"Password" andComponentName:PwdPlaceHolder];
        [self.myActionSheet addButtonWithTitle:@"Login" actionBlock:^{
            //logic code
            
            [weakSelf validateAllInputs];
            
        }];
    }else{  //init register form
        [self.myActionSheet addTextBoxWithPlaceHolder:@"Username" andComponentName:UserNamePlaceHolder];
        [self.myActionSheet addTextBoxWithPlaceHolder:@"Password" andComponentName:PwdPlaceHolder];
        [self.myActionSheet addButtonWithTitle:@"Sign Up" actionBlock:^{
            //logic code
            
            [weakSelf validateAllInputs];
            
        }];
        self.myActionSheet.usernameTextField.delegate = self;
    }

    self.myActionSheet.emailTextField.delegate = self;
    self.myActionSheet.pwdTextField.delegate = self;
    
    [self.myActionSheet show];
}

/********************************************
 
 textfield delegate methods: clicking return
 
 ****************************************/

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if(theTextField == self.myActionSheet.emailTextField){
        if(self.myActionSheet.usernameTextField)
            [self.myActionSheet.usernameTextField becomeFirstResponder];
        else
            [self.myActionSheet.pwdTextField becomeFirstResponder];
    }else if(theTextField == self.myActionSheet.usernameTextField){
            [self.myActionSheet.pwdTextField becomeFirstResponder];
    }
    else if(theTextField == self.myActionSheet.pwdTextField){
        [self validateAllInputs];
        
    }
    return NO;
}

/************************************
 
 validate all inputs, FormValidation.h
 
 ****************************************/

-(void) validateAllInputs{
    
    FormValidator *validate=[[FormValidator alloc] init];
    [validate Email:self.myActionSheet.emailTextField andUsername:self.myActionSheet.usernameTextField andPwd:self.myActionSheet.pwdTextField];
    [validate isValid];
    if([validate textFieldIsValid] == TRUE){    //success
        [self.myActionSheet dismissWithClickedButtonIndex:self.myActionSheet.cancelButtonIndex animated:YES];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            //passing the parameters
            LoginRegister *lr = [[LoginRegister alloc]init];
            [lr loginRegisterAccount:self.myActionSheet.emailTextField.text andUsernam:self.myActionSheet.usernameTextField.text andPwd:self.myActionSheet.pwdTextField.text andSELF:self];
        });

    }else{  //failure
        NSLog(@"Error Messages From Clinet Side: %@",[validate errorMsg]);
        NSString *errorString = [[validate errorMsg] componentsJoinedByString: @"\n"];
        //show the alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:errorString delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    }
}



/****************************************
 
    delegate methods for LoginRegisterForm
 
 ****************************************/
- (void)actionSheetCancel:(LoginRegisterForm *)actionSheet {
    NSLog(@"clicked cancel.");
}
- (void)actionSheet:(LoginRegisterForm *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
}
- (void)actionSheet:(LoginRegisterForm *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
}
- (void)actionSheet:(LoginRegisterForm *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"btn clicked ?");
}
- (void)willPresentActionSheet:(LoginRegisterForm *)actionSheet {
    //restore previous info
}
- (void)didPresentActionSheet:(LoginRegisterForm *)actionSheet {
    ;
}


/****************************************
 
 delegate methods for networkConnection
 
 ****************************************/


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webdata setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webdata appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:@"Network problem..please try again." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alert show];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self checkResult];
}


-(void)checkResult{
    
    NSDictionary *returnJSONtoNSdict = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    
    id status = [returnJSONtoNSdict objectForKey:@"status"];
    NSString *name = [returnJSONtoNSdict objectForKey:@"log"];
    
    
    if([status boolValue]){
        //if success,slide down current viewcontroller and "jump" into the main page
        //(postpone 0.8s to let amination fluent)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"dismissed");
            
        });

    }else{
        //if failure,reload the register or login form and load the last info
        //(password should be md5 hashed and server client use the same md5 algo?)
        //show the alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:name delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    }

}





@end
