//
//  ModifyViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ModifyViewController.h"
#import "UIButton+Bootstrap.h"
#import "FontSettings.h"
#import "AsyncRequest.h"
#import "FormValidator.h"
#import "User.h"
#import "DBOperations_User.h"

@interface ModifyViewController () <NSURLConnectionDataDelegate,UITextFieldDelegate>
{
    NSMutableData *webdata;
}

@property (weak, nonatomic) IBOutlet UITextField *myTextBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitBTN;
@end

@implementation ModifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.myTextBox.text = self.modifyString;
    self.bottomLabel.text = self.labelString;
    
    FontSettings* fs = [[FontSettings alloc]init];
    [fs TextFieldSetting:self.myTextBox];
    
    [self.submitBTN primaryStyle];
    
    
    self.title = self.viewTitle;
    
    self.myTextBox.delegate = self;
    
    webdata = [[NSMutableData alloc]init];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.myTextBox becomeFirstResponder];
}

- (IBAction)save:(id)sender {
    
    [self validateAndSave];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self validateAndSave];
    return NO;
}

-(void)validateAndSave{
    NSLog(@"validating!");
    
    User *user = [User sharedInstance];
    
    //validate
    FormValidator *validate=[[FormValidator alloc] init];
    [validate updateOneField:self.myTextBox andFieldName:@"User name"];
    
    if([validate isValid]){
        
        if(user.Uname!=self.myTextBox.text){//not waste resource if the name doesn't change
            
            //send request(this part might need to remove later for a global check)
            AsyncRequest *async = [[AsyncRequest alloc]init];
            [async modifyUserName:self.myTextBox.text andSELF:self];
            
            //update sharedInstance and DB
            user.Uname = self.myTextBox.text;
            
            DBOperations_User *dbo = [[DBOperations_User alloc]init];
            [dbo execute:[NSString stringWithFormat:@"UPDATE User SET uname = '%@' WHERE uid = '%@'",user.Uname,user.Uid]];
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        //failure
        NSLog(@"Error Messages From Clinet Side: %@",[validate errorMsg]);
        NSString *errorString = [[validate errorMsg] componentsJoinedByString: @"\n"];
        //show the alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:errorString delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    }
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

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{    //async
    NSDictionary *returnJSONtoNSdict = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    
    id status = [returnJSONtoNSdict objectForKey:@"status"];
    NSString *log = [returnJSONtoNSdict objectForKey:@"log"];
    NSLog(@"status --- -- -   %d",[status boolValue]);
    NSLog(@"log --- -- -   %@",log);
}




@end
