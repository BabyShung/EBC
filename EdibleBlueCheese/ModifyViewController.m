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


@interface ModifyViewController () <NSURLConnectionDataDelegate>
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
    
    
    webdata = [[NSMutableData alloc]init];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.myTextBox becomeFirstResponder];
}

- (IBAction)save:(id)sender {
    
    [self validateAndSave];
    
}

-(void)validateAndSave{
    NSLog(@"validating!");
    
    //send request
    AsyncRequest *async = [[AsyncRequest alloc]init];
    [async modifyUserName:self.myTextBox.text andSELF:self];
    
    //perform delegate back to prev vc
    
    //update DB
    
    //dismiss view
    [self.navigationController popViewControllerAnimated:YES];
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
}


@end
