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
@interface MeViewController ()

@property (strong, nonatomic) NSArray *section;

@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NavBarSetting *navb = [[NavBarSetting alloc]init];
    [navb setupNavBar:self.navigationController.navigationBar];
    
    
    //checking passed data
    NSLog(@"profile info?  %@",self.loggedInUser.Uid);
    NSLog(@"profile info?  %@",self.loggedInUser.Uname);
    NSLog(@"profile info?  %i",self.loggedInUser.Utype);
    NSLog(@"profile info?  %@",self.loggedInUser.Uselfie);
    
    
    
    self.section = [NSArray arrayWithObjects:@"Post", @"Like", @"XXX", nil];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {//me
        
        return 1;
        
    } else if (section == 1) {//post,like,etc
        
        return [self.section count];
    }
    else //setting
        return 1;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 0) {   //Me
        cell.textLabel.text = self.loggedInUser.Uname;
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 2) {
        cell.textLabel.text = @"Settings";
    }
    
    
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        ProfileViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
        pvc.loggedInUser = self.loggedInUser;
        [self.navigationController pushViewController:pvc animated:YES];

        
        
    
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 2){
        
    }

    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if([segue.identifier isEqualToString:@"MyProfile"]){
//        ProfileViewController* pvc = (ProfileViewController* )segue.destinationViewController;
//        pvc.loggedInUser = self.loggedInUser;
//        //delegate if needed
//    }
//}


@end
