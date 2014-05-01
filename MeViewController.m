//
//  MeViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/24/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "MeViewController.h"
#import "NavBarSetting.h"
#import "ProfileViewController.h"
#import "BadgeTableCell.h"
#import "SettingsViewController.h"
#import "FontSettings.h"
#import "User.h"

@interface MeViewController ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (strong, nonatomic) NSArray *section3;

@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NavBarSetting *navb = [[NavBarSetting alloc]init];
    [navb setupNavBar:self.navigationController.navigationBar];
    
    
    User *user = [User sharedInstance];
    self.section1 = [NSArray arrayWithObjects:user.Uname,nil];
    self.section2 = [NSArray arrayWithObjects:@"Post", @"Like", @"XXX", nil];
    self.section3 = [NSArray arrayWithObjects:@"Settings", nil];
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2,self.section3, nil];

    
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
    
    if (indexPath.section == 0) {   //Me
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 2) {//settings
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = @"Account, Feedback, Logout..";
        
    }

    
    FontSettings* cs = [[FontSettings alloc]init];
    [cs BadgeCellSetting_Arrow:cell];
    return cell;
}

/****************
 
    Row height
 
 ***************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 52;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        ProfileViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
        [self.navigationController pushViewController:pvc animated:YES];

        
        
    
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 2){
        SettingsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
        [self.navigationController pushViewController:vc animated:YES];

    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    
  
    self.tabBarController.title = @"Me";
   
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    BadgeTableCell *cell = (BadgeTableCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    
    User *user = [User sharedInstance];
    
    if(![cell.textLabel.text isEqualToString:user.Uname]){
        cell.textLabel.text = user.Uname;
        [cell.textLabel sizeToFit];
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
