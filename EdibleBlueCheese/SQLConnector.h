//
//  SQLHelper.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SQLConnector : NSObject
{
    sqlite3 *database;
}
@property (nonatomic) sqlite3 *database;

/***************************************
 
    Use this method, singleton
 
 **************************************/

+ (SQLConnector *)sharedInstance;


/***************************************
 
    methods
 
 **************************************/

- (NSString *) sqliteDBFilePath;// filePath

- (void) openDB;//open a connection

- (void) closeDB;//close a connection

- (void) createEditableCopyOfDatabaseIfNeeded;

-(void) createUserTable: (NSString *) tablename //create user table
                withUid:(NSString *) field1
           withUsername:(NSString *) field2
           withPassword:(NSString *) field3
              withUtype:(NSString *) field4
             withSelfIE:(NSString *) field5
            withPrimary:(NSString *) field6
    withExecuteDateTime:(NSString *) field7
      withLastLoginTime:(NSString *) field8;


@end
