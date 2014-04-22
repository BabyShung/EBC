//
//  ProfileViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ProfileViewController.h"
#import "ImagePlaceholderHelper.h"
#import "NavBarSetting.h"
#import "UILayers.h"
@interface ProfileViewController ()

//@property(nonatomic) BOOL loggedIn;

@end

@implementation ProfileViewController

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

    
    NavBarSetting *navb = [[NavBarSetting alloc]init];
    [navb setupNavBar:self.navigationController.navigationBar];
    
    self.Selfie.image = [[ImagePlaceholderHelper sharedInstance] placerholderAvatarWithSize:self.Selfie.frame.size];
    
   // [self.Cover fillWithPlaceholderImageAndText:@"Click to change cover" fillColor:[UIColor colorWithRed:0.861f green:0.791f blue:0.467f alpha:1.00f]];
    
    [self.Cover setImage:[UIImage imageNamed:@"mycover.jpg"]];
    
    //add layers to the image frame
    UILayers *uil = [[UILayers alloc]init];
    CALayer * calayer = [uil borderLayerWidth:self.Selfie.frame.size.width andHeight:self.Selfie.frame.size.height andBorderWidth:2.5 andColor:[UIColor whiteColor]];
    [self.Selfie.layer addSublayer:calayer];
    calayer = [uil borderLayerWidth:self.Selfie.frame.size.width andHeight:self.Selfie.frame.size.height andBorderWidth:0.3 andColor:[UIColor grayColor]];
    [self.Selfie.layer addSublayer:calayer];
    
}

-(void)viewDidAppear:(BOOL)animated{
//    if(!self.loggedIn){//if not logged in
//        UIViewController *tv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
//        [self presentViewController:tv animated:NO completion:nil];
//        self.loggedIn = YES;
//    }
    
  
}

- (IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
//        UIViewController *tv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
//        [self presentViewController:tv animated:YES completion:nil];
}


@end
