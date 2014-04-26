//
//  DBOperations_User.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/22/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "DBOperations_User.h"


@implementation DBOperations_User


-(instancetype) init  //set up connection
{
	if ((self=[super init]) )
    {
        self.sqlc = [SQLConnector sharedInstance];
        [self.sqlc openDB];
	}
	return self;
}

//remember to open and close DB for all your methods



/***************************************
 
    Helpers, pattern of sql statements
 
 **************************************/

-(BOOL)HelperReturnBool:(NSString *)sql
{
    
    
    sqlite3_stmt *stm = nil;
    
    if (stm == nil)
    {
		if (sqlite3_prepare_v2([self.sqlc database], [sql UTF8String], -1, &stm, NULL) != SQLITE_OK)
        {
			NSAssert1(0, @"!Error: failed to prepare statement with message '%s'.", sqlite3_errmsg([self.sqlc database]));
		}
	}
    BOOL result = sqlite3_step(stm) == SQLITE_ROW;
    
	if(result){
        return YES;
	}
    else{
        return NO;
    }
}


-(void)execute:(NSString *)sql
{
    sqlite3_stmt *stm = nil;
    
    if (stm == nil)
    {
		if (sqlite3_prepare_v2([self.sqlc database], [sql UTF8String], -1, &stm, NULL) != SQLITE_OK)
        {
			NSAssert1(0, @"!Error: failed to prepare statement with message '%s'.", sqlite3_errmsg([self.sqlc database]));
		}
	}
    
    int success = sqlite3_step(stm);
    
    if (success == SQLITE_ERROR)
    {
        NSAssert1(0, @"Error: failed to execute table with message '%s'.", sqlite3_errmsg([self.sqlc database]));
    }
    NSLog(@"******** SQL executed successfully ********");
}

-(User *)FetchAUser:(NSString *)sql
{
    sqlite3_stmt *stm = nil;
    
    if (stm == nil)
    {
		if (sqlite3_prepare_v2([self.sqlc database], [sql UTF8String], -1, &stm, NULL) != SQLITE_OK)
        {
			NSAssert1(0, @"!Error: failed to prepare statement with message '%s'.", sqlite3_errmsg([self.sqlc database]));
		}
	}
    
    User *tmp;
    while (sqlite3_step(stm) == SQLITE_ROW)
	{
        NSString* uid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 0)];
        NSString* uname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 1)];
        NSString* upwd = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 2)];
        NSUInteger utype = sqlite3_column_int(stm, 3);
        //NSString* uselfie = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 4)];
        tmp = [User sharedInstanceWithUid:uid andUname:uname andUpwd:upwd andUtype:utype andUselfie:nil];
        
        
    }
    return tmp;
}

-(void)dealloc
{
   // [self.sqlc closeDB];
}


@end
