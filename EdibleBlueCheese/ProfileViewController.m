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

#import "AsyncRequest.h"

#import "StorageFile.h"
#import "User.h"

#import "ImageProcessing.h"

@interface ProfileViewController () <NSURLConnectionDataDelegate>
{
    NSMutableData *webdata;
}


@property(nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    webdata = [[NSMutableData alloc]init];
    
    User *user = [User sharedInstance];
    
    NavBarSetting *navb = [[NavBarSetting alloc]init];
    
    //if no selfie, show the default one
    if(!user.Uselfie){
        self.Selfie.image = [[ImagePlaceholderHelper sharedInstance] placerholderAvatarWithSize:self.Selfie.frame.size];
    }else{
        ImageProcessing *ip = [[ImageProcessing alloc]init];
        UIImage* fitImage = [ip scaleImage:[UIImage imageWithData:user.Uselfie] toSize:CGSizeMake(140, 140)];
        self.Selfie.image = fitImage;
    }
    
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
    
    
    
    //new thread to init image picker
    dispatch_async(dispatch_get_main_queue(), ^{
        //init imageController
        self.imagePicker = [UIImagePickerController new];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [navb setupNavBar:self.imagePicker.navigationBar];
        
    });
    
    self.UnameLabel.text = user.Uname;
    
    self.title =@"My Profile";
    
    
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
    
    
    
    ImageProcessing *ip = [[ImageProcessing alloc]init];
    
    //resolution for iphone5
    UIImage *finalImage = [ip scaleImage:tmpImage toSize:CGSizeMake(640,1136)];
    
    NSData *imgData = UIImageJPEGRepresentation(finalImage, 0);
    //NSLog(@"*****Size of Image(bytes):  %d",[imgData length]);
    NSLog(@"*****Size of Image(width):  %f",finalImage.size.width);
    NSLog(@"*****Size of Image(width):  %f",finalImage.size.height);

    
    //shrink size to 140*140 and show on our 70*70 imageView
    UIImage *compressedImage = [ip scaleImage:finalImage toSize:CGSizeMake(140,140)];
    [self.Selfie setImage:compressedImage];
   
    
    User *user = [User sharedInstance];
    user.Uselfie = imgData;
    
    
    //another thread to send image to server
    dispatch_async(dispatch_get_main_queue(), ^{

        AsyncRequest *async = [[AsyncRequest alloc]init];
        [async changeSelfie_Selfie:imgData andSELF:self];
        NSLog(@"Any luck?? --------");
    });

    
    [self dismissViewControllerAnimated:YES completion:nil];

}



//pop noti view
- (IBAction)demoNotify:(id)sender {
    EdibleAlertView *popin = [[EdibleAlertView alloc] init];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleCrossDissolve];
    [popin setPopinOptions:BKTPopinDefault];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}


/****************************************
 
 delegate methods for networkConnection
 
 ****************************************/


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webdata setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webdata appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.." message:@"Network problem..please try again." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alert show];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{    //async
    NSDictionary *returnJSONtoNSdict = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    
    id status = [returnJSONtoNSdict objectForKey:@"status"];
    NSString *log = [returnJSONtoNSdict objectForKey:@"log"];
    NSLog(@"selfie status --- -- -   %d",[status boolValue]);
    NSLog(@"selfie log --- -- -   %@",log);
    
    
    if([status boolValue]){
        //
        User *user = [User sharedInstance];
        StorageFile *file = [[StorageFile alloc]init];
        [file storeAsLocalFile:user.Uselfie andFileName:@"user_selfie.jpg"];
    }
}

@end
