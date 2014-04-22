//
//  AppDelegate.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "AppDelegate.h"


#import "SQLConnector.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
	
	if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {

		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
		[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
		NSDictionary *attributes = @{ NSFontAttributeName: [UIFont fontWithName:@"Heiti TC" size:20],
									  NSForegroundColorAttributeName: [UIColor whiteColor]};
		[[UINavigationBar appearance] setTitleTextAttributes:attributes];
        
	}
    
    
    
    SQLConnector *sqlh=[[SQLConnector alloc] init];
    [sqlh openDB];  //open sql connection
    
    //Tables
    [sqlh createUserTable:@"User" withUid:@"Uid" withUsername:@"Uname" withPassword:@"Upwd" withSelfIE:@"Selfie" withExecuteDateTime:@"ts"];
    
    
    
    [sqlh closeDB];//close db

    
    
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    UIViewController *viewController =  [storyboard instantiateViewControllerWithIdentifier:@"LoginRegister"];
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
