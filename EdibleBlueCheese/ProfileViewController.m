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
#import "UIImage+operation.h"
#import "DBOperations_User.h"

#import "UIViewController+MaryPopin.h"
#import "EdibleAlertView.h"

#import "MeViewController.h"



#import "User.h"

@interface ProfileViewController ()

@property(nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation ProfileViewController

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
    
    
    
    UITapGestureRecognizer *selfieTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfieTapDetected)];
    selfieTap.numberOfTapsRequired = 1;
    self.Selfie.userInteractionEnabled = YES;
    [self.Selfie addGestureRecognizer:selfieTap];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //init imageController
        self.imagePicker = [UIImagePickerController new];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [navb setupNavBar:self.imagePicker.navigationBar];
        
    });
    
    User *user = [User sharedInstance];
    
    self.UnameLabel.text = user.Uname;
    
    self.title =@"My Profile";
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)selfieTapDetected{
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:Nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take photo", @"Choose Existing", nil];
        [actionSheet showInView:self.view];
    } else {
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != actionSheet.cancelButtonIndex){
        if (buttonIndex == 0)
            [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        else if (buttonIndex == 1)
            [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    } else{
        
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    NSLog(@"finished taking photo");
    
    //put the image
    CGRect croppedRect=[[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
    //get original image
    UIImage *original=[info objectForKey:UIImagePickerControllerOriginalImage];
 
    //rotate the image if needed
    UIImage *rotatedCorrectly;
    if (original.imageOrientation!=UIImageOrientationUp)
        rotatedCorrectly = [original rotate:original.imageOrientation];
    else
        rotatedCorrectly = original;
    

    
    CGImageRef ref= CGImageCreateWithImageInRect(rotatedCorrectly.CGImage, croppedRect);
    UIImage *tmpImage = [UIImage imageWithCGImage:ref];
    
    //resolution for iphone5
    UIImage *finalImage = [self scaleImage:tmpImage toSize:CGSizeMake(640,1136)];
    
    NSData *imgData = UIImageJPEGRepresentation(finalImage, 0);
    NSLog(@"*****Size of Image(bytes):  %d",[imgData length]);
    NSLog(@"*****Size of Image(width):  %f",finalImage.size.width);
    NSLog(@"*****Size of Image(width):  %f",finalImage.size.height);

    
    
    UIImage *compressedImage = [self scaleImage:finalImage toSize:CGSizeMake(140,140)];
    
    [self.Selfie setImage:compressedImage];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //ip5 320 568,,,,ip4 320 480
    
    //different devices
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        if (screenSize.height > 480.0f) {
//            /*Do iPhone 5 stuff here.*/
//        } else {
//            /*Do iPhone Classic stuff here.*/
//
//        }
//    } else {
//        /*Do iPad stuff here.*/
//    }

    
}


-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (IBAction)demoNotify:(id)sender {
    EdibleAlertView *popin = [[EdibleAlertView alloc] init];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleCrossDissolve];
    [popin setPopinOptions:BKTPopinDefault];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

@end
