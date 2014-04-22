//
//  UILayers.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/22/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "UILayers.h"

@implementation UILayers


-(CALayer *)borderLayerWidth:(CGFloat) width andHeight:(CGFloat) height andBorderWidth:(CGFloat) bw andColor:(UIColor *) color{
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, width, height);
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setBorderWidth:bw];
    [borderLayer setBorderColor:[color CGColor]];
    return borderLayer;
}


@end
