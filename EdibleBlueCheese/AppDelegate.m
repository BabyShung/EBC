//
//  AppDelegate.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "AppDelegate.h"

#import "DBOperations_User.h"
#import "SQLConnector.h"


#import "NavBarSetting.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //set the theme of all navigation bar
    NavBarSetting *nbsetting = [[NavBarSetting alloc]init];
    [nbsetting setNavBarTheme];

     //[[UILabel appearance] setFont:[UIFont fontWithName:@"Heiti TC" size:17.0]];
    
    //[[UILabel appearance] setTextColor:[UIColor colorWithRed:(73/255.0) green:(79/255.0) blue:(80/255.0) alpha:1]];
    
    //DB:: tables
    SQLConnector *sqlh= [SQLConnector sharedInstance];//singleton
    [sqlh openDB];  //open sql connection
    //Tables
    [sqlh createUserTable:@"User" withUid:@"uid" withUsername:@"uname" withPassword:@"upwd" withUtype:@"utype" withSelfIE:@"uselfie" withPrimary:@"primaryUser" withExecuteDateTime:@"create_ts" withLastLoginTime:@"last_ts"];
    [sqlh closeDB];//close db
    
    
    //check if there is a loggedIn primary
    DBOperations_User *dbo = [[DBOperations_User alloc]init];
    
    //init the static shared instance in memory
    User *user = [dbo FetchAUser:@"SELECT uid,uname,upwd,uselfie,utype from User where primaryUser = 1"];
    NSLog(@"user exist?  %@",user);

    
    
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
