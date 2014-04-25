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
    
    self.title = @"My Account";
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
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        cell.badgeString = self.loggedInUser.Uid;
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        if(indexPath.row ==0){
            cell.badgeString = self.loggedInUser.Uname;
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.badgeTextColor = [UIColor grayColor];
    cell.badgeColor = [UIColor clearColor];
    cell.badge.fontSize = 16;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){//click email
        ModifyViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Modify"];
        mvc.modifyString = self.loggedInUser.Uid;
        [self.navigationController pushViewController:mvc animated:YES];
        
        
        
        
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 2){
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
