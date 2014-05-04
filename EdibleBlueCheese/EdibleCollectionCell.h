//
//  HaoCollectionCell.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/1/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdibleCollectionCell : UICollectionViewCell



@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *subtitleLabel;


@property (nonatomic, strong, readwrite) UIImage *image;

@property (nonatomic, strong, readwrite) UIImage *ArrowIndicator;

@property (nonatomic, assign, readwrite) CGPoint imageOffset;



@end
