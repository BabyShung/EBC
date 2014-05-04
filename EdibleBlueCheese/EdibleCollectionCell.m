//
//  HaoCollectionCell.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/1/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "EdibleCollectionCell.h"
#import "UILayers.h"

#define LABEL_HEIGHT 20.f
#define TOP_MARGIN 3.0f
#define LEFT_MARGIN 25.0f

#define IMAGE_REAL_HEIGHT 110.0f

@interface EdibleCollectionCell()

@property (nonatomic, strong, readwrite) UIImageView *BackgroundImageView;
@property (nonatomic, strong, readwrite) UIImageView *ArrowImageView;
@end

@implementation EdibleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self setupCell];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    
    UILayers *uil = [[UILayers alloc]init];
    CAShapeLayer *layer =  [uil innerShadow:self.frame andTopOffset:100 andBottomOffset:0 andLeftOffset:0 andRightOffset:0];

    
    
    // Clip subviews
    self.clipsToBounds = YES;
    
    // Add image subview
    self.BackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, IMAGE_REAL_HEIGHT)];
    self.BackgroundImageView.backgroundColor = [UIColor clearColor];
    self.BackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.BackgroundImageView.clipsToBounds = NO;
    self.BackgroundImageView.image = [UIImage imageNamed:@"mycover.jpg"];
    
    [self.BackgroundImageView.layer addSublayer:layer];
    
    [self addSubview:self.BackgroundImageView];
    
    
    // Add arrow image subview
    self.ArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, self.bounds.size.height/2-15, 30, 30)];

    self.ArrowImageView.backgroundColor = [UIColor clearColor];
    self.ArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.ArrowImageView.clipsToBounds = NO;
    self.ArrowImageView.image = [UIImage imageNamed:@"right_arrow.png"];
    
    
    [self addSubview:self.ArrowImageView];
    

    
    //show the logout label
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x+LEFT_MARGIN, self.bounds.origin.y+TOP_MARGIN, self.bounds.size.width, LABEL_HEIGHT)];
    myLabel.font = [UIFont systemFontOfSize:18];
    myLabel.text = [NSString stringWithFormat:@"aaa"];
    myLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel = myLabel;
    [self addSubview:self.titleLabel];

    
    UILabel *myLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y+LABEL_HEIGHT, self.bounds.size.width, LABEL_HEIGHT)];
    myLabel2.font = [UIFont systemFontOfSize:18];
    myLabel2.text = [NSString stringWithFormat:@"aaa"];
    myLabel2.textColor = [UIColor whiteColor];
    self.subtitleLabel = myLabel2;
    [self addSubview:self.subtitleLabel];

    
    
    }
# pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    // Store image
    self.BackgroundImageView.image = image;
    
    // Update padding
    [self setImageOffset:self.imageOffset];
}

//- (void)setImageOffset:(CGPoint)imageOffset
//{
//    // Store padding value
//    self.imageOffset = imageOffset;
//    
//    // Grow image view
//    CGRect frame = self.BackgroundImageView.bounds;
//    CGRect offsetFrame = CGRectOffset(frame, self.imageOffset.x, self.imageOffset.y);
//    self.BackgroundImageView.frame = offsetFrame;
//}



@end
