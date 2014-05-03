//
//  ImageProcessing.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/3/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageProcessing : NSObject

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end
