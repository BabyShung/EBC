//
//  StorageFile.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/3/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "StorageFile.h"
#import "DBOperations_User.h"
#import "User.h"

@implementation StorageFile


-(void)storeAsLocalFile:(NSData *)data andFileName:(NSString*) name{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,name];
        
        NSLog(@"Writing stored file path-----------------: %@",filePath);
        [data writeToFile:filePath atomically:YES];
        NSLog(@"File stored ! ! !");
        
        User *user = [User sharedInstance];
        DBOperations_User *dbo = [[DBOperations_User alloc]init];
        
        
        [dbo execute:[NSString stringWithFormat:@"UPDATE User SET uselfie = '%@' WHERE uid = '%@'",name , user.Uid]];
    });

    
}

-(NSData *)readDataFromLocalDocument:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileName];
    
    NSLog(@"Reading stored file path-----------------: %@",filePath);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        NSLog(@"File exits!!!!");
        return data;
    }
    else
    {
        NSLog(@"File not exits");
        return nil;
    }

}



@end
