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
#import "ImagePlaceholderHelper.h"
#import "FontSettings.h"
#import "OtherProfileViewController.h"
#import "Profiler.h"

@interface SearchResultViewController ()

@property (nonatomic,strong) UIImage *Selfie;

@end

@implementation SearchResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Results";
    
    self.Selfie =  [[ImagePlaceholderHelper sharedInstance] placerholderAvatarWithSize:CGSizeMake(45, 45)];
    
    //prevent empty case crash
    if(!self.users)
        self.users = [NSMutableArray array];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BadgeTableCell *cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    
    
    // Configure the cell...
    FontSettings* cs = [[FontSettings alloc]init];
    [cs BadgeCellSetting_Arrow:cell];
    
    
    
    NSDictionary *user_instance = self.users[indexPath.row];

    
    cell.textLabel.text = [user_instance objectForKey:@"uname"];
    
    [cell.imageView setImage:self.Selfie];
    
    cell.badgeString = @"XX Info";

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.users[indexPath.row];
    
    OtherProfileViewController *opvc = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherProfile"];
    
    NSString* uid = [dict objectForKey:@"uid"];
    NSString* uname = [dict objectForKey:@"uname"];
    NSUInteger utype = [[dict objectForKey:@"utype"] integerValue];
    //NSData* uselfie = [dict objectForKey:@"uselfie"];
    
    Profiler *pf = [[Profiler alloc]initWithUid:uid andUname:uname andUtype:utype andUselfie:nil];
    opvc.profiler = pf;
    
    [self.navigationController pushViewController:opvc animated:YES];
    
}

/****************
 
 Row height
 
 ***************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
