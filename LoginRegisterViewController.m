//
//  LoginRegisterViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "WCActionSheet.h"
#import "FormValidation.h"
#import "validation.h"

#define EmailPlaceHolder @"Email"
#define UserNamePlaceHolder @"Username"
#define PwdPlaceHolder @"Password"

@interface LoginRegisterViewController () <WCActionSheetDelegate,UITextFieldDelegate>

@property (nonatomic, strong) WCActionSheet *myActionSheet;

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

}



- (IBAction)showLoginForm:(id)sender {

    [self formInitializeAndIfIsLogin:YES];
    
        //    [actionSheet addButtonWithTitle:@"Hi!" actionBlock:^{
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hi!" message:@"My name is Wojtek and I made it" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles: nil];
    //        [alert show];
    //    }];

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
    
    self.myActionSheet = [[WCActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
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

/************************************
 
 delegate methods for textfield
 
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
        //submit
        NSLog(@"sumbit!");
        [self validateAllInputs];
        
    }
    
    return true;
}

-(void) validateAllInputs{
    
    validation *validate=[[validation alloc] init];
    
    //pass the textFields
    [validate Email:self.myActionSheet.emailTextField FieldName:@"Email"];
    [validate Required:self.myActionSheet.emailTextField FieldName:@"Email"];
    [validate Required:self.myActionSheet.pwdTextField FieldName:@"Password"];
    [validate MinLength:4 textField:self.myActionSheet.pwdTextField FieldName:@"Password"];
    [validate MaxLength:20 textField:self.myActionSheet.pwdTextField FieldName:@"Password"];
    
    if(self.myActionSheet.usernameTextField){//register case
        [validate Required:self.myActionSheet.usernameTextField FieldName:@"Username"];
        [validate MaxLength:20 textField:self.myActionSheet.usernameTextField FieldName:@"Username"];
    }
    
    [validate isValid];
    
    //----Check valid or not
    if([validate textFieldIsValid] == TRUE){
        NSLog(@"Everything validated");
        //self.errorLabel.hidden = TRUE;
        //self.errorLabel.text = @"";
    }else{
        //----Show Error Messages From errorMsg Array
        NSLog(@"Error Messages From Clinet Side: %@",[validate errorMsg]);
        
        NSString *errorString = [[validate errorMsg] componentsJoinedByString: @"\n"];
        
        NSLog(@"Error:\n%@",errorString);
        //self.errorLabel.hidden = false;
       // self.errorLabel.text = errorString;
    }

    
}


/************************************
 
    delegate methods for WCActionSheet
 
 ****************************************/
- (void)actionSheetCancel:(WCActionSheet *)actionSheet {
    
}

- (void)actionSheet:(WCActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    ;
}

- (void)actionSheet:(WCActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ;
}

- (void)actionSheet:(WCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    ;
}

- (void)willPresentActionSheet:(WCActionSheet *)actionSheet {
    ;
}

- (void)didPresentActionSheet:(WCActionSheet *)actionSheet {
    ;
}


@end
