//
//  ViewController.m
//  leftRightScrollView
//
//  Created by Hao Zheng on 4/19/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardScrollView.h"

@interface CardCollectionViewController () <CardScrollViewDataSource>

@property (nonatomic, strong) CardScrollView *scrollView;
@property (nonatomic, strong) NSArray *photos;

@end

@implementation CardCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initControl];
    [self setContent:nil];
    [self reloadData];
}

#pragma mark - view's life cycle

- (void)initControl
{
    self.scrollView = [[CardScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.foregroundScreenEdgeInsets = UIEdgeInsetsZero;
    //_scrollView.foregroundScreenEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    
    //insert subview
    [self.view insertSubview:_scrollView atIndex:0];
}

- (void)setContent:(id)content
{
    //init array and put names
    self.photos = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg"];
}

- (void)reloadData
{
    _scrollView.dataSource = self;
}

- (IBAction)prev:(id)sender {
    [_scrollView prevItem];
}

- (IBAction)next:(id)sender {
    [_scrollView nextItem];
}

- (IBAction)goBack:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PWParallaxScrollViewSource

- (NSInteger)numberOfItemsInScrollView:(CardScrollView *)scrollView
{
    return [self.photos count];
}

- (UIView *)backgroundViewAtIndex:(NSInteger)index scrollView:(CardScrollView *)scrollView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.photos[index]]];
    //imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //imageView.contentMode = UIViewContentModeScaleToFill;
    return imageView;
}

- (UIView *)foregroundViewAtIndex:(NSInteger)index scrollView:(CardScrollView *)scrollView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 250, 60)];
    [label setBackgroundColor:[UIColor blackColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:50.0f]];
    [label setTextAlignment:NSTextAlignmentCenter];
    //title can be changed
    [label setText:[NSString stringWithFormat:@"Title %@", @(index + 1)]];
    [label setAlpha:0.7f];
    [label setUserInteractionEnabled:YES];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //the same frame as label, cool
    [button setFrame:label.bounds];
    [button setShowsTouchWhenHighlighted:YES];
    //add selector
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    //add the btn as a subview of label (on top)
    [label addSubview:button];
    
    return label;
}

- (void)test
{
    NSLog(@"hit test");
}

#pragma mark - PWParallaxScrollViewDelegate

- (void)didChangeIndex:(NSInteger)index scrollView:(CardScrollView *)scrollView {
    //not working, check?
    NSLog(@"index changed");
}


@end
