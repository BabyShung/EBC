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
#import "UIAlertView+Blocks.h"

#import "AsyncRequest.h"
#import "LoadingAnimation.h"

#import "User.h"
#import "MeViewController.h"
#import "DBOperations_User.h"

#import "edi_md5.h"

#define EmailPlaceHolder @"Email"
#define UserNamePlaceHolder @"Username"
#define PwdPlaceHolder @"Password"




@interface LoginRegisterViewController () <WCActionSheetDelegate,UITextFieldDelegate,NSURLConnectionDataDelegate>
{
    NSMutableData *webdata;
}

@property (nonatomic) BOOL isLogging;

@property (nonatomic) BOOL clickedLogin;
@property (nonatomic) BOOL clickedRegister;

@property (nonatomic, strong) NSString* HashedPwd;

@property (nonatomic,strong) NSString* lr_e;
@property (nonatomic,strong) NSString* lr_p;
@property (nonatomic,strong) NSString* cr_e;
@property (nonatomic,strong) NSString* cr_n;
@property (nonatomic,strong) NSString* cr_p;

@property (nonatomic, strong) LoginRegisterForm *myActionSheet;
@property (nonatomic,strong) LoadingAnimation *loadingImage;

@property (weak, nonatomic) IBOutlet UIButton *loginBTN;
@property (weak, nonatomic) IBOutlet UIButton *registerBTN;


@end

@implementation LoginRegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //btn radius
    self.loginBTN.layer.cornerRadius = 60.0f;
    self.registerBTN.layer.cornerRadius = 60.0f;
    
    //animate label
    [self.AnimatedLabel animateWithWords:@[@"We're the Edible",@"It's the best App",@"Do you like it?"] forDuration:3.0f];
    
    webdata = [[NSMutableData alloc]init];
    

    
}

/*****************************************
 
 clicking btns events
 
 ****************************************/

- (IBAction)showLoginForm:(id)sender {
    self.clickedLogin = YES;
    self.clickedRegister = NO;
    [self formInitializeAndIfIsLogin:YES];
    
}

- (IBAction)showRegisterForm:(id)sender {
    self.clickedRegister = YES;
    self.clickedLogin = NO;
    [self formInitializeAndIfIsLogin:NO];
    
}

/*****************************************
 
 initialize based on which form
 
 ****************************************/
-(void) formInitializeAndIfIsLogin:(BOOL) IsLogin{
    
    //you can't refer to self or properties on self from within a block that will be strongly retained by self, so use a weakself
    __weak typeof(self) weakSelf = self;
    
    self.myActionSheet = [[LoginRegisterForm alloc] initWithDelegate:self andShowFromBottom:NO cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
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
    
    //Hao added
    if(self.clickedLogin){
        self.myActionSheet.emailTextField.text = self.lr_e;
        self.myActionSheet.pwdTextField.text = self.lr_p;
    }else{
        self.myActionSheet.emailTextField.text = self.cr_e;
        self.myActionSheet.pwdTextField.text = self.cr_n;
        self.myActionSheet.usernameTextField.text = self.cr_p;
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(self.clickedLogin){
        if(textField == self.myActionSheet.emailTextField){
            self.lr_e = self.myActionSheet.emailTextField.text;
        }else if(textField == self.myActionSheet.pwdTextField){
            self.lr_p = self.myActionSheet.pwdTextField.text;
        }

    }else{
    
    if(textField == self.myActionSheet.emailTextField){
        self.cr_e = self.myActionSheet.emailTextField.text;
    }else if(textField == self.myActionSheet.usernameTextField){
       self.cr_n = self.myActionSheet.usernameTextField.text;
    }
    else if(textField == self.myActionSheet.pwdTextField)
       self.cr_p = self.myActionSheet.pwdTextField.text;
    }

}

/************************************
 
 validate all inputs, FormValidation.h
 
 ****************************************/

-(void) validateAllInputs{
    
    
    
    FormValidator *validate=[[FormValidator alloc] init];
    [validate Email:self.myActionSheet.emailTextField andUsername:self.myActionSheet.usernameTextField andPwd:self.myActionSheet.pwdTextField];
    
    if([validate isValid]){    //success
        [self.myActionSheet dismissWithClickedButtonIndex:self.myActionSheet.cancelButtonIndex animated:YES];
        
        
        //start animation
        if(!self.loadingImage){
            self.loadingImage = [[LoadingAnimation alloc] initWithStyle:RTSpinKitViewStyleWave color:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1.0]];
            CGRect screenBounds = [[UIScreen mainScreen] bounds];
            self.loadingImage.center = CGPointMake(CGRectGetMidX(screenBounds), screenBounds.size.height*0.7);
            [self.view addSubview:self.loadingImage];
        }
        [self.loadingImage startAnimating];
        
        self.isLogging = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            
            
            //md5 the pwd
            edi_md5 *edimd5 = [[edi_md5 alloc]init];
            self.HashedPwd = [edimd5 md5:self.myActionSheet.pwdTextField.text];
            
         
            //passing the parameters, request should send hashedPWD***
            AsyncRequest *lr = [[AsyncRequest alloc]init];
            [lr loginRegisterAccount:self.myActionSheet.emailTextField.text andUsernam:self.myActionSheet.usernameTextField.text andPwd:self.HashedPwd andSELF:self];
          
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
    if(self.isLogging){
        self.loginBTN.enabled = NO;
        self.registerBTN.enabled = NO;
    }else{
        self.loginBTN.enabled = YES;
        self.registerBTN.enabled = YES;
    }
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

/****************************************
 
 check if login success or failure
 
 ****************************************/
-(void)checkResult{
    
    NSDictionary *returnJSONtoNSdict = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    
    id status = [returnJSONtoNSdict objectForKey:@"status"];
    NSString *log = [returnJSONtoNSdict objectForKey:@"log"];
    
    
    if([status boolValue]){
        //if success,slide down current viewcontroller and "jump" into the main page
        //(postpone 0.8s to let amination fluent)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            
            
            
            /****************************************
             
             testing return values
             
             ****************************************/
            NSString *uid = [returnJSONtoNSdict objectForKey:@"uid"];
            NSString *uname = [returnJSONtoNSdict objectForKey:@"uname"];
            NSString *utype = [returnJSONtoNSdict objectForKey:@"utype"];
            NSMutableArray *uselfie = [returnJSONtoNSdict objectForKey:@"uselfie"];
            //NSString *ucreate_time = [returnJSONtoNSdict objectForKey:@"ucreate_time"];
            
            NSLog(@"Uselfie-------  %@",uselfie);
            
            
//            unsigned c = uselfie.count;
//            uint8_t *bytes = malloc(sizeof(*bytes) * c);
//            
//            unsigned i;
//            for (i = 0; i < c; i++)
//            {
//                NSString *str = [uselfie objectAtIndex:i];
//                int byte = [str intValue];
//                bytes[i] = byte;
//            }
//            
//            NSData *imageData = [NSData dataWithBytesNoCopy:bytes length:c freeWhenDone:YES];
//            UIImage *image = [UIImage imageWithData:imageData];
            
            
            
            
            //init the sharedInstance
            User *user = [User sharedInstanceWithUid:uid andUname:uname andUpwd:self.HashedPwd andUtype:[utype integerValue]   andUselfie:nil];
            if(!user){//no sharedInstance
                user = [User cheatingWithUid:uid andUname:uname andUpwd:self.HashedPwd andUtype:[utype integerValue]   andUselfie:nil];
            }
            

            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            
            
            //write primary to account
            DBOperations_User *dbo = [[DBOperations_User alloc]init];
            [dbo execute:[NSString stringWithFormat:@"INSERT OR REPLACE INTO User (uid,uname,upwd,primaryUser,last_ts) VALUES ('%@','%@','%@',1,datetime('now','localtime'))",user.Uid,user.Uname,self.HashedPwd]];
            
            
            
            //stop the animation
            if(self.loadingImage)
                [self.loadingImage stopAnimating];
            
            self.isLogging = NO;
            self.loginBTN.enabled = YES;
            self.registerBTN.enabled = YES;
            
        });
        
    }else{
        //if failure,reload the register or login form and load the last info
        //(password should be md5 hashed and server client use the same md5 algo?)
        //show the alert
        if(!log){
            log = @"Network error, please try again.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:log delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
            if (buttonIndex == [alertView cancelButtonIndex]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                    
                    [self formInitializeAndIfIsLogin:self.clickedLogin?YES:NO];
                    
                });
            }
        }];
        
        
        //stop the animation
        if(self.loadingImage)
            [self.loadingImage stopAnimating];
        
        self.isLogging = NO;
        self.loginBTN.enabled = YES;
        self.registerBTN.enabled = YES;
    }
    
    
}


@end
