//
//  MeViewController.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/24/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface MeViewController : UITableViewController

@property (nonatomic,strong) User *loggedInUser;

@end
