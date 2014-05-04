//
//  OtherProfileViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/4/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "OtherProfileViewController.h"
#import "BadgeTableCell.h"
#import "ImagePlaceholderHelper.h"
#import "FontSettings.h"

@interface OtherProfileViewController ()

@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (strong, nonatomic) NSArray *menu;

@property (strong, nonatomic) UIImage *Selfie;

@end

@implementation OtherProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.section1 = [NSArray arrayWithObjects:@"Name",nil];
    self.section2 = [NSArray arrayWithObjects: @"Region", @"Signature", @"Cards", nil];
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2,nil];
    
    //self.tableView.layer.borderColor = [[UIColor clearColor] CGColor];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.Selfie =  [[ImagePlaceholderHelper sharedInstance] placerholderAvatarWithSize:CGSizeMake(70, 70)];
    
    
    if(!self.profiler)
        self.profiler = [[Profiler alloc]init];
    
    
    self.title = @"Profile";
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
    }else
        return [self.section2 count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BadgeTableCell *cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    
    FontSettings *fs = [[FontSettings alloc]init];
    
    if(indexPath.section == 0){
        //bad code, fix that later
        cell = [[BadgeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell" andisImageCell:YES];
      
        
        [cell.imageView setImage:self.Selfie];
        [cell.imageView.layer setMasksToBounds:YES];
        [cell.imageView.layer setCornerRadius:5];
        
        
        cell.textLabel.text = self.profiler.Uname;
        
        [fs BadgeCellSetting:cell];
        
    }else if(indexPath.section == 1){
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        
        if(indexPath.row == 0){
            
            cell.badgeString = @"Iowa City";
        }else{
            cell.badgeString = @"XX";
        }
        [fs BadgeCellSetting_BadgeString:cell];
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
    if (indexPath.section == 0) {
        return 92;
    }
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
