//
//  SQLHelper.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "SQLConnector.h"

static NSString *kSQLiteFileName = @"EdibleBlueCheeseDB.sqlite3";


@implementation SQLConnector

@synthesize database;


+ (SQLConnector *)sharedInstance
{
    // 1
    static SQLConnector *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SQLConnector alloc] init];
        
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

/*******************************
 
    Basic functions
 
 ******************************/

- (NSString *) sqliteDBFilePath  //get the file path of DB
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:kSQLiteFileName];
	NSLog(@"Database path = %@", path);
	
	return path;
}


- (void) openDB // open a db connection
{
    if (sqlite3_open([[self sqliteDBFilePath] UTF8String], &database) != SQLITE_OK)
	{
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }else{
        NSLog(@"Database opened");
    }
}

- (void) closeDB // close a db connection
{
    if (sqlite3_close(database) != SQLITE_OK)
	{
        NSAssert1(0, @"Error: failed to close database with message '%s'.", sqlite3_errmsg(database));
    }
    else{
        NSLog(@"Database closed");
    }
}

// Creates a writable copy of the bundled default database in the application Documents directory.
- (void) createEditableCopyOfDatabaseIfNeeded
{
    // First, test for existence.
    NSFileManager *fileManager = [NSFileManager defaultManager];
	
    NSString *writableDBPath = [self sqliteDBFilePath];
    // NSLog(@"%@", writableDBPath);
    BOOL success = [fileManager fileExistsAtPath: writableDBPath];
    if (success)
	{
		return;
	}
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteFileName];
    NSError *error;
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success)
	{
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

/*******************************
 
    Tables
 
 
 User:  Uid, Username, Upwd, Utype, SelfIE, Primary, ExecuteDateTime, lastLoginTime

 
 
 
 ******************************/

-(void) createUserTable: (NSString *) tablename //create user table
                withUid:(NSString *) field1
           withUsername:(NSString *) field2
           withPassword:(NSString *) field3
              withUtype:(NSString *) field4
             withSelfIE:(NSString *) field5
            withPrimary:(NSString *) field6
    withExecuteDateTime:(NSString *) field7
      withLastLoginTime:(NSString *) field8{
    
    
    char *err;
    NSString *sql =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY, '%@' TEXT NOT NULL,'%@' TEXT NOT NULL,'%@' INTEGER DEFAULT 1,'%@' TEXT,'%@' INTEGER DEFAULT 0,'%@' TimeStamp NOT NULL DEFAULT (datetime('now','localtime')),'%@' TimeStamp NOT NULL DEFAULT (datetime('now','localtime')));",tablename,field1,field2,field3,field4,field5,field6,field7,field8];
    
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Failed to create User table with message '%s'.", sqlite3_errmsg(database));
    }else{
        NSLog(@"User table created.");
    }
    
}







@end
