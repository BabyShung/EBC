//
//  UIImageView+Placeholer.m
//  DRImagePlacerholerHelperExample
//
//  Created by Albert on 11.08.13.
//  Copyright (c) 2013 Albert Schulz. All rights reserved.
//

#import "UIImageView+Placeholder.h"
#import "ImagePlaceholderHelper.h"

@implementation UIImageView (Placeholder)

- (void)fillWithPlaceholderImage
{
    self.image = [[ImagePlaceholderHelper sharedInstance] placerholderImageWithSize:self.frame.size];
}

- (void)fillWithPlaceholderImageAndFillColor:(UIColor *)fillColor
{
    self.image = [[ImagePlaceholderHelper sharedInstance] placerholderImageWithSize:self.frame.size fillColor:fillColor];
}

- (void)fillWithPlaceholderImageAndText:(NSString *)text
{
    self.image = [[ImagePlaceholderHelper sharedInstance] placerholderImageWithSize:self.frame.size text:text];
}

- (void)fillWithPlaceholderImageAndText:(NSString *)text fillColor:(UIColor *)fillColor
{
    self.image = [[ImagePlaceholderHelper sharedInstance] placerholderImageWithSize:self.frame.size text:text fillColor:fillColor];
}

//avatar
- (void)fillWithAvatarPlaceholder
{
    self.image = [[ImagePlaceholderHelper sharedInstance] placerholderAvatarWithSize:self.frame.size];
}

@end
