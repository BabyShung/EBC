//
//  LoginRegisterViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "WCActionSheet.h"


@interface LoginRegisterViewController () <WCActionSheetDelegate>

@end

@implementation LoginRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    [self.AnimatedLabel animateWithWords:@[@"We're the Edible",@"It's the best App",@"Do you like it?"] forDuration:3.0f];
    
}

- (IBAction)showLoginForm:(id)sender {
    WCActionSheet *actionSheet = [[WCActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    
    //    [actionSheet addButtonWithTitle:@"Hi!" actionBlock:^{
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hi!" message:@"My name is Wojtek and I made it" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles: nil];
    //        [alert show];
    //    }];
    
    
    //P.S: you can change placeholder name but can't change componentName (fixed in .m file)
    [actionSheet addTextBoxWithPlaceHolder:@"Email" andComponentName:@"Email"];
    [actionSheet addTextBoxWithPlaceHolder:@"Password" andComponentName:@"Password"];
    [actionSheet addButtonWithTitle:@"Login" actionBlock:^{//logic code
        
    }];
    
    [actionSheet show];
}

- (IBAction)showRegisterForm:(id)sender {
    
    WCActionSheet *actionSheet = [[WCActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];

    
    //P.S: you can change placeholder name but can't change componentName (fixed in .m file)
    [actionSheet addTextBoxWithPlaceHolder:@"Email" andComponentName:@"Email"];
    [actionSheet addTextBoxWithPlaceHolder:@"Username" andComponentName:@"Username"];
    [actionSheet addTextBoxWithPlaceHolder:@"Password" andComponentName:@"Password"];
    [actionSheet addButtonWithTitle:@"Sign Up" actionBlock:^{//logic code
        
    }];
    
    [actionSheet show];

    
}



/************************************
 
    delegate from WCActionSheet
 
 ****************************************/
- (void)actionSheetCancel:(WCActionSheet *)actionSheet {
    
}

- (void)actionSheet:(WCActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    ;
}

- (void)actionSheet:(WCActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ;
}

- (void)actionSheet:(WCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    ;
}

- (void)willPresentActionSheet:(WCActionSheet *)actionSheet {
    ;
}

- (void)didPresentActionSheet:(WCActionSheet *)actionSheet {
    ;
}


@end
