//
//  ModifyViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ModifyViewController.h"

@interface ModifyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation ModifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.myTextBox.text = self.modifyString;
    

    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.myTextBox becomeFirstResponder];
}



@end
