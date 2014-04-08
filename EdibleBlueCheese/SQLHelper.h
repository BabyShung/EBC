//
//  SQLHelper.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SQLHelper : NSObject
{
    sqlite3 *database;
}
@property (nonatomic) sqlite3 *database;

// filePath
- (NSString *) sqliteDBFilePath;

- (void) openDB;//open a connection

- (void) closeDB;//close a connection

- (void) createEditableCopyOfDatabaseIfNeeded;

-(void) createUserTable: (NSString *) tablename
                withUid:(NSString *) field1
         withUsername:(NSString *) field2
           withPassword:(NSString *) field3
           withSelfIE:(NSString *) field4
    withExecuteDateTime:(NSString *) field5;


@end
