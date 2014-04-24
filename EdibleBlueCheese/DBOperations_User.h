//
//  DBOperations_User.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/22/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "SQLConnector.h"
#import "User.h"
@interface DBOperations_User : NSObject

@property (nonatomic) SQLConnector *sqlc;



-(BOOL)HelperReturnBool:(NSString *)sql;

-(void)execute:(NSString *)sql;

-(User *)FetchAUser:(NSString *)sql;

@end
