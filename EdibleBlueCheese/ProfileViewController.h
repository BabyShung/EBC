//
//  ProfileViewController.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *Selfie;

@property (weak, nonatomic) IBOutlet UIImageView *Cover;

@property (weak, nonatomic) IBOutlet UILabel *UnameLabel;



@end
