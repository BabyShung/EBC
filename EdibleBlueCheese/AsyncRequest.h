//
//  LoginRegister.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncRequest : NSObject 


-(void)loginRegisterAccount:(NSString *)email andUsernam:(NSString *)uname andPwd:(NSString *) pwd andSELF:(id) selfy;

-(void)modifyUserName:(NSString*)username andSELF:(id)selfy;

-(void)modifyPWD_oldPwd:(NSString*)oldpwd andNextPwd:(NSString*)nextpwd andConfirmPwd:(NSString*)confirmpwd andSELF:(id)selfy;


@end
