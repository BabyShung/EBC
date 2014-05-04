//
//  LoginRegister.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncRequest : NSObject 

//login or register request
-(void)loginRegisterAccount:(NSString *)email andUsernam:(NSString *)uname andPwd:(NSString *) pwd andSELF:(id) selfy;

//update username
-(void)modifyUserName:(NSString*)username andSELF:(id)selfy;

//update pwd
-(void)modifyPWD_oldPwd:(NSString*)oldpwd andNextPwd:(NSString*)nextpwd andConfirmPwd:(NSString*)confirmpwd andSELF:(id)selfy;

//update selfie
-(void)changeSelfie_Selfie:(NSData *) imageData andSELF:(id)selfy;

//search user
-(void)searchUser:(NSString*)nameORid andSELF:(id)selfy;



@end
