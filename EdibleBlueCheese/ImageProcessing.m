//
//  ImageProcessing.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/3/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ImageProcessing.h"

@implementation ImageProcessing

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
