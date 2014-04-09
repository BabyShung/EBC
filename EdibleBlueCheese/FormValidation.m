//
//  FormValidation.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "FormValidation.h"

@implementation FormValidation

- (BOOL)validateEmail:(NSString*)email andUserName:(NSString*) username andPwd:(NSString*)pwd{
    
    return YES;
}

- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateRequired:(NSString*)input{
    return (input.length == 0)? NO:YES;
}

@end
