//
//  LoginRegister.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "LoginRegister.h"

#define loginURL @"http://1-dot-edible-bluecheese-server.appspot.com/login"
#define registerURL @"http://1-dot-edible-bluecheese-server.appspot.com/registration"

@implementation LoginRegister 

-(void)loginRegisterAccount:(NSString *)email andUsernam:(NSString *)uname andPwd:(NSString *) pwd andSELF:(id) selfy{
    
    NSDictionary *dict;
    NSURL *url;
    
    if(uname){  //register
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:email, @"uid",uname, @"uname", pwd, @"upwd", nil];
        url = [NSURL URLWithString:registerURL];
    }else{  //login
        dict = [NSDictionary dictionaryWithObjectsAndKeys:email, @"uid", pwd, @"upwd", nil];
        url = [NSURL URLWithString:loginURL];
    }
    
    NSError *error;
    //convert dictionary to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding]);
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:selfy];
    [conn start];
    
}





@end
