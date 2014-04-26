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

@interface AccountViewController ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.section1 = [NSArray arrayWithObjects:@"Email",nil];
    self.section2 = [NSArray arrayWithObjects:@"User Name",@"Password",  nil];
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2, nil];
    
    self.title = @"Account";
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
    }else {
        return [self.section2 count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BadgeTableCell *cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    FontSettings* cs = [[FontSettings alloc]init];
    [cs BadgeCellSetting_BadgeString_Arrow:cell];
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        cell.badgeString = self.loggedInUser.Uid;
        
        //.....
        cell.userInteractionEnabled = NO;//disable this cell
        //over write the cell setting
        [cs BadgeCellSetting_BadgeString:cell];
        
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        if(indexPath.row ==0){
            cell.badgeString = self.loggedInUser.Uname;
        }
    }
    
    
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){//click email (currently cell is disabled
        ModifyViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Modify"];
        mvc.modifyString = self.loggedInUser.Uid;
       
        [self.navigationController pushViewController:mvc animated:YES];
        
        
        
        
    }else if(indexPath.section == 1 && indexPath.row == 0){//click username
        
        ModifyViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Modify"];
        mvc.modifyString = self.loggedInUser.Uname;
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
@end
