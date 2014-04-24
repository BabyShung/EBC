//
//  Manual_Auto_Login.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/23/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "Manual_Auto_Login.h"
#import "DBOperations_User.h"
#import "ProfileViewController.h"

@implementation Manual_Auto_Login

-(void)auto_or_manual_login:(UIWindow *)window{
    //check if there is a loggedIn primary
    DBOperations_User *dbo = [[DBOperations_User alloc]init];
    User* user = [dbo FetchAUser:@"SELECT uid,uname,upwd from User where primaryUser = 1"];
    
    NSString* storyBoardID = nil;
    
    window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    if(user){//will auto login
        NSLog(@"should auto login");
        storyBoardID = @"tabbar";

        UITabBarController *tabbarVC = [storyboard instantiateViewControllerWithIdentifier:storyBoardID];
        tabbarVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        UINavigationController *firstNVC = [tabbarVC.viewControllers objectAtIndex:0];
        ProfileViewController *firstVC = (ProfileViewController*)firstNVC.visibleViewController;
        
        
        User *tmp = [User sharedInstanceWithUid:user.Uid andUname:user.Uname andUpwd:user.Upwd andUtype:user.Utype  andUselfie:nil];
        //*****assign the user
        firstVC.loggedInUser = tmp;
        
        window.rootViewController = tabbarVC;
    }else{
        NSLog(@"should login manually");
        storyBoardID = @"LoginRegister";
        
        UIViewController *viewController =  [storyboard instantiateViewControllerWithIdentifier:storyBoardID];
        window.rootViewController = viewController;
        
    }
    
    [window makeKeyAndVisible];
}

@end
