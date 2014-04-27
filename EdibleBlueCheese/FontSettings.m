//
//  CellSetting.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "FontSettings.h"

@implementation FontSettings

/*******************
 
    basic
 
 *******************/
-(void)BadgeCellSetting:(BadgeTableCell *) cell{

    cell.detailTextLabel.textColor = [UIColor grayColor];

    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];//using system bold size
    cell.textLabel.textColor = [UIColor colorWithRed:(48/255.0) green:(56/255.0) blue:(57/255.0) alpha:1];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
}

-(void)TextFieldSetting:(UITextField *)textfield{
    
    textfield.font = [UIFont systemFontOfSize:18];//seems not working
    textfield.textColor = [UIColor colorWithRed:(48/255.0) green:(56/255.0) blue:(57/255.0) alpha:1];
}

-(void)TextFieldSetting_ForPWD:(UITextField *)textfield{
    
    [self TextFieldSetting:textfield];
    textfield.secureTextEntry = YES;
}

/*******************
 
    customize
 
 *******************/

-(void)BadgeCellSetting_BadgeString:(BadgeTableCell *) cell{
    
    [self BadgeCellSetting:cell];
    
    
    cell.badgeTextColor = [UIColor grayColor];
    cell.badgeColor = [UIColor clearColor];
    cell.badge.fontSize = 16;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
}


-(void)BadgeCellSetting_Arrow:(BadgeTableCell *) cell{
    
    [self BadgeCellSetting:cell];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

}

-(void)BadgeCellSetting_BadgeString_Arrow:(BadgeTableCell *) cell{
    [self BadgeCellSetting_BadgeString:cell];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
