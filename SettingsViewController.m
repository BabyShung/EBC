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
@interface SettingsViewController ()

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
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.badgeString = @"ss";
    cell.badgeTextColor = [UIColor grayColor];
    cell.badgeColor = [UIColor clearColor];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        AccountViewController *avc = [self.storyboard instantiateViewControllerWithIdentifier:@"Account"];
        avc.loggedInUser = self.loggedInUser;
        [self.navigationController pushViewController:avc animated:YES];
        
        
        
        
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 2){
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
