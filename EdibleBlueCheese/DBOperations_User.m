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

@end
