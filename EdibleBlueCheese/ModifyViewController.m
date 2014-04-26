//
//  ModifyViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ModifyViewController.h"
#import "UIButton+Bootstrap.h"
#import "FontSettings.h"

@interface ModifyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitBTN;
@end

@implementation ModifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.myTextBox.text = self.modifyString;
    self.bottomLabel.text = self.labelString;
    
    FontSettings* fs = [[FontSettings alloc]init];
    [fs TextFieldSetting:self.myTextBox];
    
    [self.submitBTN primaryStyle];
    
    
    self.title = self.viewTitle;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.myTextBox becomeFirstResponder];
}

- (IBAction)save:(id)sender {
    
    [self validateAndSave];
    
}

-(void)validateAndSave{
    NSLog(@"validating!");
    
    //send request
    
    //perform delegate
    
    //update DB
    
    //dismiss view
    
}

@end
