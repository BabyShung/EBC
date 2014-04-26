//
//  LoginRegister.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncRequest : NSObject <NSURLConnectionDataDelegate>


-(void)loginRegisterAccount:(NSString *)email andUsernam:(NSString *)uname andPwd:(NSString *) pwd andSELF:(id) selfy;

@end
