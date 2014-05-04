//
//  CellSetting.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BadgeTableCell.h"

@interface FontSettings : NSObject

-(void)BadgeCellSetting:(BadgeTableCell *) cell;

-(void)BadgeCellSetting_BadgeString:(BadgeTableCell *) cell;

-(void)BadgeCellSetting_Arrow:(BadgeTableCell *) cell;

-(void)BadgeCellSetting_BadgeString_Arrow:(BadgeTableCell *) cell;

-(void)TextFieldSetting:(UITextField *)textfield;

-(void)TextFieldSetting_ForPWD:(UITextField *)textfield;

@end
