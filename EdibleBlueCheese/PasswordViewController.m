//
//  PasswordViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/25/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "PasswordViewController.h"
#import "FontSettings.h"
#import "UIButton+Bootstrap.h"

@interface PasswordViewController () <UITextFieldDelegate>

@end

@implementation PasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FontSettings* fs = [[FontSettings alloc]init];
    [fs TextFieldSetting_ForPWD:self.oldPwd];
    [fs TextFieldSetting_ForPWD:self.nextPwd];
    [fs TextFieldSetting_ForPWD:self.confirmPwd];
    
    [self.submitBTN successStyle];
    
    self.title = self.viewTitle;
    
    self.oldPwd.delegate = self;
    self.nextPwd.delegate = self;
    self.confirmPwd.delegate = self;
    
    //different devices
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
        } else {
            /*Do iPhone Classic stuff here.*/
            self.submitBTN.hidden = YES;
            UIBarButtonItem *barSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(validateAndSave)];
            self.navigationItem.rightBarButtonItem = barSaveButton;
        }
    } else {
        /*Do iPad stuff here.*/
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self.oldPwd becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.oldPwd){
        [self.nextPwd becomeFirstResponder];
    }else if(textField == self.nextPwd){
        [self.confirmPwd becomeFirstResponder];
    }
    else if(textField == self.confirmPwd){
        [self validateAndSave];
    }
    return NO;
}

-(void)validateAndSave{
    NSLog(@"validating!");
}

- (IBAction)clickSaveBTN:(id)sender {
    [self validateAndSave];
}
@end
