//
//  ScrollViewController.h
//  ScrollingNavbarDemo
//
//  Created by Hao Zheng on 4/20/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.

#import "ScrollViewController.h"
#import "UIViewController+ScrollingNavbar.h"
#import "NavBarSetting.h"
#import "User.h"
#import "LoginRegisterViewController.h"

@interface ScrollViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 320, 40)];
	[label setText:@"Hello"];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setFont:[UIFont fontWithName:@"Heiti TC" size:24]];
	[label setTextColor:[UIColor blackColor]];
	[label setBackgroundColor:[UIColor clearColor]];
	[self.scrollView addSubview:label];
    
    
    
    NavBarSetting *navb = [[NavBarSetting alloc]init];
    [navb setupNavBar:self.navigationController.navigationBar];
    

	// Let's fake some content
	[self.scrollView setContentSize:CGSizeMake(320, 1540)];
	
	// Just call this line to enable the scrolling navbar
	[self followScrollView:self.scrollView withDelay:60];
	
    
    self.scrollView.delegate = self;

}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self showNavBarAnimated:NO];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	// This enables the user to scroll down the navbar by tapping the status bar.
	[self showNavbar];
	
	return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //check second login based on the sharedInstance
    User *user = [User sharedInstance];
    if(!user){//not loaded primary user, then show the loginRegisterView
        LoginRegisterViewController *lrvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
        lrvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:lrvc animated:NO completion:nil];
    }
    
    
}

@end
