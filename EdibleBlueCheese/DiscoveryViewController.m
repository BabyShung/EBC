//
//  HaoViewController.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/1/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "DiscoveryViewController.h"

#import "EdibleCollectionCell.h"

#import "UILayers.h"

#import "ImageProcessing.h"

@interface DiscoveryViewController ()

@property (nonatomic,strong) CAShapeLayer *shadowLayer;


@end

@implementation DiscoveryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, 0, 60, 0);
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.title = @"Discover";
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EdibleCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    

    NSString *imageName = nil;
    
    NSString *titleName = nil;
    
    if (indexPath.row == 0) {
        
        titleName = @"Nearby Restaurant";
        imageName = @"discover_restaurant.jpg";
    }else if (indexPath.row == 1){
        titleName = @"My Cards";
        imageName = @"discover_oldbuilding.jpg";
    }else if (indexPath.row == 2){
        titleName = @"Hotels";
        imageName = @"discover_walking.jpg";
    }else if (indexPath.row == 3){
        titleName = @"Parties";
        imageName = @"discover_bridge.jpg";
    }else {
        titleName = @"Travel";
        imageName = @"discover_river.jpg";
    }
    cell.titleLabel.text = titleName;
    cell.image = [UIImage imageNamed:imageName] ;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //if(indexPath.row == 0){
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Nearby"];
        [self.navigationController pushViewController:vc animated:YES];
    //}
    
    
    NSLog(@"didselect %ld",(long)indexPath.row);
}




@end
