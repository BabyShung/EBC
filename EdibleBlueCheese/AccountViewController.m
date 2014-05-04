//
//  AccountViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/24/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "AccountViewController.h"
#import "BadgeTableCell.h"
#import "ModifyViewController.h"
#import "FontSettings.h"
#import "PasswordViewController.h"
#import "User.h"

@interface AccountViewController ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@property (strong, nonatomic) User *user;

@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.user = [User sharedInstance];
    
    self.section1 = [NSArray arrayWithObjects:@"Email",nil];
    self.section2 = [NSArray arrayWithObjects:@"User Name",@"Password",  nil];
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2, nil];
    
    self.title = @"Account";
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
    }else {
        return [self.section2 count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BadgeTableCell *cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    FontSettings* cs = [[FontSettings alloc]init];
    [cs BadgeCellSetting_BadgeString_Arrow:cell];
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        cell.badgeString = self.user.Uid;
        cell.badgeColor = [UIColor blackColor];
        
        NSLog(@"^^^^^ %@", self.user);
         NSLog(@"^^^^^ %@", self.user.Uid);
        NSLog(@"^^^^^ %@", [User sharedInstance]);
        
        //.....
        cell.userInteractionEnabled = NO;//disable this cell
        //over write the cell setting
        [cs BadgeCellSetting_BadgeString:cell];
        
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        if(indexPath.row ==0){
            cell.badgeString = self.user.Uname;
        }
    }
    
    
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){//click email (currently cell is disabled
        ModifyViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Modify"];
        mvc.modifyString = self.user.Uid;
       
        [self.navigationController pushViewController:mvc animated:YES];
        
        
        
        
    }else if(indexPath.section == 1 && indexPath.row == 0){//click username
        
        ModifyViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Modify"];
        mvc.modifyString = self.user.Uname;
        //mvc.labelString = @"Button Haha";
        mvc.viewTitle = @"User Name";
         mvc.labelString = @"User name should not be more than 20 characters.";
        
        [self.navigationController pushViewController:mvc animated:YES];
        
        
    }else if(indexPath.section == 1 && indexPath.row == 1){//click pwd
        PasswordViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Password"];

        
        pvc.viewTitle = @"Password";
        [self.navigationController pushViewController:pvc animated:YES];
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

-(void)viewWillAppear:(BOOL)animated{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    BadgeTableCell *cell = (BadgeTableCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    
    User *user = [User sharedInstance];
    
    if(![cell.badgeString isEqualToString:user.Uname]){
        cell.badgeString = user.Uname;
    }
    

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
