//
//  XYZViewController.h
//  TestCamera
//
//  Created by Shiyao Wang on 4/26/14.
//  Copyright (c) 2014 Edible, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XYZViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *frameForCapture;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)takePhoto:(id)sender;

@end
