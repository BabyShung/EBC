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


#pragma mark - UICollectionViewDatasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EdibleCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    

    if (indexPath.row == 0) {
        
        cell.titleLabel.text = @"Hao";
        cell.image = [UIImage imageNamed:@"discover_restaurant.jpg"];
    }else if (indexPath.row == 1){
        //cell.titleLabel.text = @"Collection";
        cell.image = [UIImage imageNamed:@"discover_oldbuilding.jpg"];
    }else if (indexPath.row == 2){
        //cell.titleLabel.text = @"Collection";
        cell.image = [UIImage imageNamed:@"discover_walking.jpg"];
    }else if (indexPath.row == 3){
        //cell.titleLabel.text = @"Collection";
        cell.image = [UIImage imageNamed:@"discover_bridge.jpg"];
    }else {
        //cell.titleLabel.text = @"Collection";
        cell.image = [UIImage imageNamed:@"discover_river.jpg"];
    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Nearby"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    NSLog(@"didselect %ld",(long)indexPath.row);
}




@end
