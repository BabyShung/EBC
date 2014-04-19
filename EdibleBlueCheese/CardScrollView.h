//
//  PSParallaxScrollView.h
//  PWParallaxScrollView
//
//  Created by wpsteak on 13/6/16.
//  Copyright (c) 2013年 wpsteak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardScrollViewDataSource;

@interface CardScrollView : UIView

@property (nonatomic, assign) id<CardScrollViewDataSource> dataSource;
@property (nonatomic, readonly) NSInteger currentIndex;
@property (nonatomic, assign) UIEdgeInsets foregroundScreenEdgeInsets;

//methods
- (void)prevItem;
- (void)nextItem;
- (void)moveToIndex:(NSInteger)index;
- (void)reloadData;

@end

//delegates
@protocol CardScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInScrollView:(CardScrollView *)scrollView;
- (UIView *)backgroundViewAtIndex:(NSInteger)index scrollView:(CardScrollView *)scrollView;

@optional
- (UIView *)foregroundViewAtIndex:(NSInteger)index scrollView:(CardScrollView *)scrollView;

@end

