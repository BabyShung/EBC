//
//  SearchResultViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/29/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "SearchResultViewController.h"
#import "BadgeTableCell.h"
#import "FontSettings.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BadgeTableCell *cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    FontSettings* cs = [[FontSettings alloc]init];
    [cs BadgeCellSetting:cell];
    
    cell.textLabel.text = @"11";
//    if (indexPath.section == 0) {
//        //cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
//        
//   
//        
//        
//    }else if (indexPath.section == 1) {
//        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
//        
//    }else if (indexPath.section == 2){
//        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
//    }
//    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
