//
//  FindContactsViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/29/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "FindContactsViewController.h"
#import "User.h"
#import "BadgeTableCell.h"
#import "FontSettings.h"
#import "UIAlertView+Blocks.h"
#import "SearchResultViewController.h"

#import "AsyncRequest.h"


@interface FindContactsViewController () <UITextFieldDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *webdata;
}
@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (strong, nonatomic) NSArray *section3;


@property (weak, nonatomic) UITextField *searchBox;

@property (strong, nonatomic) User *user;

@end

@implementation FindContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webdata = [[NSMutableData alloc]init];

    
    self.user = [User sharedInstance];
    
    self.section1 = [NSArray arrayWithObjects:@"User Name/Email",nil];
    self.section2 = [NSArray arrayWithObjects:@"XX Contacts",@"XX1 Contacts",nil];
    self.section3 = [NSArray arrayWithObjects:@"XXX",@"Friend Nearby",  nil];
    
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2, self.section3,nil];
    
    self.title = @"Add Contacts";
    
    self.searchBox.delegate = self;
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [self.section1 count];
    }else if(section == 1){
        return [self.section2 count];
    }else
        return [self.section3 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BadgeTableCell *cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    FontSettings* cs = [[FontSettings alloc]init];
    [cs BadgeCellSetting_BadgeString_Arrow:cell];
    
    
    if (indexPath.section == 0) {
        //cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];

        

        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 3, cell.frame.size.width, cell.frame.size.height)];
        textField.textColor = [UIColor colorWithRed:(48/255.0) green:(56/255.0) blue:(57/255.0) alpha:1];
        textField.font = [UIFont systemFontOfSize:19.f];
        textField.placeholder = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.backgroundColor = [UIColor clearColor];
        textField.keyboardType = UIKeyboardTypeDefault;
        
        textField.clearButtonMode = UITextFieldViewModeAlways;
        
        [cell.contentView addSubview:textField];
        
        self.searchBox = textField;
        
        self.searchBox.delegate = self;
        
        [cs BadgeCellSetting:cell];
        

        
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];

    }else if (indexPath.section == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/****************
 
 Row height
 
 ***************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if(self.searchBox)
       [self.searchBox resignFirstResponder];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    
    [self searchUsers:textField.text];
    
    [textField resignFirstResponder];
    
    return NO;
}

-(void)searchUsers:(NSString*)name{
    
    //perform async task
    AsyncRequest *async = [[AsyncRequest alloc]init];
    
    [async searchUser:name andSELF:self];
    
    //success -> push to result view
    
    //failure -> show alert view
    
    
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
    NSMutableArray *users = [returnJSONtoNSdict objectForKey:@"results"];
    NSLog(@"find contacts status --- -- -   %d",[status boolValue]);
    NSLog(@"log --- -- -   %@",log);


    if([status boolValue]){

        SearchResultViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResult"];
        svc.users = users;
        [self.navigationController pushViewController:svc animated:YES];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User not exists" message:@"User not found. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];

        
        [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
            [self.searchBox becomeFirstResponder];
        }];
        

    }
}




@end
