//
//  PasswordViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "PasswordViewController.h"
#import "FontSettings.h"
#import "UIButton+Bootstrap.h"
#import "AsyncRequest.h"
#import "FormValidator.h"
#import "SVProgressHUD.h"
#import "DBOperations_User.h"

@interface PasswordViewController () <UITextFieldDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *webdata;
}
@end

@implementation PasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webdata = [[NSMutableData alloc]init];
    
    FontSettings* fs = [[FontSettings alloc]init];
    [fs TextFieldSetting_ForPWD:self.oldPwd];
    [fs TextFieldSetting_ForPWD:self.nextPwd];
    [fs TextFieldSetting_ForPWD:self.confirmPwd];
    
    [self.submitBTN successStyle];
    
    self.title = self.viewTitle;
    
    self.oldPwd.delegate = self;
    self.nextPwd.delegate = self;
    self.confirmPwd.delegate = self;
    
    //different devices
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
        } else {
            /*Do iPhone Classic stuff here.*/
            self.submitBTN.hidden = YES;
            UIBarButtonItem *barSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(validateAndSave)];
            self.navigationItem.rightBarButtonItem = barSaveButton;
        }
    } else {
        /*Do iPad stuff here.*/
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self.oldPwd becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.oldPwd){
        [self.nextPwd becomeFirstResponder];
    }else if(textField == self.nextPwd){
        [self.confirmPwd becomeFirstResponder];
    }
    else if(textField == self.confirmPwd){
        [self validateAndSave];
    }
    return NO;
}

-(void)validateAndSave{
    NSLog(@"validating!");
    
    /***************************************************************************
     
     self.nextPwd and self.confirmPwd preprocess to hashvalue using hash function
     
     ***************************************************************************/
    
    //validate
    FormValidator *validate=[[FormValidator alloc] init];
    [validate OldPwd:self.oldPwd andNextPwd:self.nextPwd andConfirmPwd:self.confirmPwd];
    
    if([validate isValid]){    //validation success
        self.submitBTN.enabled = NO;
        
        //show the progress view
        [SVProgressHUD show];
        
        //send request
        AsyncRequest *async = [[AsyncRequest alloc]init];
        [async modifyPWD_oldPwd:self.oldPwd.text andNextPwd:self.nextPwd.text andConfirmPwd:self.confirmPwd.text andSELF:self];
        
        
        
        
    }else{  //failure
        NSLog(@"Error Messages From Clinet Side: %@",[validate errorMsg]);
        NSString *errorString = [[validate errorMsg] componentsJoinedByString: @"\n"];
        //show the alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:errorString delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
        
        //follow up to enhance user experience
        if(![validate requiredError]){
            self.nextPwd.text = @"";
            self.confirmPwd.text = @"";
            [self.nextPwd becomeFirstResponder];
        }
    }


    
}

- (IBAction)clickSaveBTN:(id)sender {
    [self validateAndSave];
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
    NSDictionary *returnJSONtoNSdict = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    
    
    
    id status = [returnJSONtoNSdict objectForKey:@"status"];
    NSString *log = [returnJSONtoNSdict objectForKey:@"log"];
    NSLog(@"status --- -- -   %d",[status boolValue]);
    NSLog(@"log --- -- -   %@",log);
    
    if([status boolValue]){
        [SVProgressHUD showSuccessWithStatus:@"Done!"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
        
        //**** update DB
        DBOperations_User *dbu = [[DBOperations_User alloc]init];
        User *user = [User sharedInstance];

        user.Upwd = self.nextPwd.text; //****** late change to hash value

        [dbu execute:[NSString stringWithFormat:@"UPDATE User SET upwd = '%@' where uid = '%@'",user.Upwd,user.Uid]];
        
        
        //**** perform delegate back to prev vc
        //no need to do that ! since we are using singleton! 
        
    }else{
        [SVProgressHUD dismiss];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:log delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
        self.oldPwd.text = @"";
        self.nextPwd.text = @"";
        self.confirmPwd.text = @"";
        [self.oldPwd becomeFirstResponder];
        self.submitBTN.enabled = YES;
        
    }
}

@end
