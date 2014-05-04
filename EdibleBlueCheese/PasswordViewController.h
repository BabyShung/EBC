//
//  PasswordViewController.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *nextPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
@property (weak, nonatomic) IBOutlet UIButton *submitBTN;

@property (nonatomic,strong) NSString* viewTitle;

- (IBAction)clickSaveBTN:(id)sender;
@end
