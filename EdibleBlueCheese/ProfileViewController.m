//
//  ProfileViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ProfileViewController.h"
#import "ImagePlaceholderHelper.h"


@interface ProfileViewController ()

@property(nonatomic) BOOL loggedIn;

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

    self.Selfie.image = [[ImagePlaceholderHelper sharedInstance] placerholderAvatarWithSize:self.Selfie.frame.size];
    
    [self.Cover fillWithPlaceholderImageAndText:@"Click to change cover" fillColor:[UIColor colorWithRed:0.861f green:0.791f blue:0.467f alpha:1.00f]];
    
    

    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (self.Selfie.frame.size.width), (self.Selfie.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setBorderWidth:2.5];
    [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.Selfie.layer addSublayer:borderLayer];
    
    CALayer *borderLayer2 = [CALayer layer];
    CGRect borderFrame2 = CGRectMake(0, 0, (self.Selfie.frame.size.width), (self.Selfie.frame.size.height));
    [borderLayer2 setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer2 setFrame:borderFrame2];
    [borderLayer2 setBorderWidth:0.3];
    [borderLayer2 setBorderColor:[[UIColor grayColor] CGColor]];
    [self.Selfie.layer addSublayer:borderLayer2];
    
}

-(void)viewDidAppear:(BOOL)animated{
    if(!self.loggedIn){//if not logged in
        UIViewController *tv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
        [self presentViewController:tv animated:NO completion:nil];
        self.loggedIn = YES;
    }
}

- (IBAction)dismiss:(id)sender {
    UIViewController *tv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
    [self presentViewController:tv animated:YES completion:nil];
}


@end
