//
//  FormValidation.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormValidation : NSObject

- (BOOL)validateEmail:(NSString*)email andUserName:(NSString*) username andPwd:(NSString*)pwd;

- (BOOL)validateEmail:(NSString*)email;

- (BOOL)validateRequired:(NSString*)input;


@end
