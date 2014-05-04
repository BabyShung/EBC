//
//  SettingsViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/24/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "SettingsViewController.h"
#import "BadgeTableCell.h"
#import "AccountViewController.h"
#import "FontSettings.h"
#import "User.h"
#import "DBOperations_User.h"
#import "LoginRegisterForm.h"

@interface SettingsViewController () <WCActionSheetDelegate>

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (strong, nonatomic) NSArray *section3;

@end

@implementation SettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.section1 = [NSArray arrayWithObjects:@"Account",nil];
    self.section2 = [NSArray arrayWithObjects:@"Follow us on Weibo",@"Feedback", @"About", nil];
    self.section3 = [NSArray arrayWithObjects:@"Logout", nil];
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2,self.section3, nil];
    
    self.title = @"Settings";
    self.tabBarController.tabBar.hidden = YES;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
       return [self.section1 count];
    }else if(section ==1){
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
    [cs BadgeCellSetting_Arrow:cell];
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 2) {//logout
       // cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
        
        //show the logout label
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 3, cell.frame.size.width, cell.frame.size.height)];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.font = [UIFont boldSystemFontOfSize:18];
        myLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
        myLabel.textColor = [UIColor colorWithRed:(48/255.0) green:(56/255.0) blue:(57/255.0) alpha:1];
        
        [cell.contentView addSubview:myLabel];
        
        [cs BadgeCellSetting:cell];
    
    }

    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        AccountViewController *avc = [self.storyboard instantiateViewControllerWithIdentifier:@"Account"];
        [self.navigationController pushViewController:avc animated:YES];
        
        
        
        
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 2){//logout
        
        //show a confirm dialog
        LoginRegisterForm *lrf =  [[LoginRegisterForm alloc] initWithDelegate:self andShowFromBottom:YES cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
        
        lrf.blurRadius = 50.f;
        
        [lrf addButtonWithTitle:@"Log Out" actionBlock:^{
            
            /************************
            
             log out release things
             
             ************************/
            
           
            
            //write primary to account
            DBOperations_User *dbo = [[DBOperations_User alloc]init];
            User *user = [User sharedInstance];
            
            NSLog(@"==========Logging out, release resources==========");
            
            NSLog(@"%@",dbo.sqlc);
            
            NSLog(@"before: user  %@ ",user);
            
            [dbo execute:[NSString stringWithFormat:@"UPDATE User SET primaryUser = 0 WHERE uid = '%@'",user.Uid]];
   
            
            
            //set sharedInstance to nil
            user = [User setTONil];
            NSLog(@"==========Logging out, release resources==========");
            NSLog(@"after: user  %@ ",user);
            
            
            /************************************
             
             PS: The below order matters!
             
             ***********************************/
            [self.parentViewController.childViewControllers[0] setSelectedIndex:0];
            
            UIViewController *tv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
            tv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:tv animated:YES completion:nil];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }];

        [lrf show];
        
    }
    
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
@end
