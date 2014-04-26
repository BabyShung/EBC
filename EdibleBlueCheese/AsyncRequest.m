//
//  LoginRegister.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "AsyncRequest.h"
#import "User.h"

#define loginURL @"http://1-dot-edible-bluecheese-server.appspot.com/login"
#define registerURL @"http://1-dot-edible-bluecheese-server.appspot.com/registration"
#define changeSELFIE @"http://1-dot-edible-bluecheese-server.appspot.com/changeselfie"
#define updatePROFILE @"http://1-dot-edible-bluecheese-server.appspot.com/updateprofile"
#define changePASSWORD @"http://1-dot-edible-bluecheese-server.appspot.com/changepassword"
#define searchUSER @"http://1-dot-edible-bluecheese-server.appspot.com/searchuser"
#define getUserINFO @"http://1-dot-edible-bluecheese-server.appspot.com/getuserinfo"

@implementation AsyncRequest 


/************************
 
 request methods
 
 ************************/

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
    
    [self performAsyncTask:selfy andDictionary:dict andURL:url];
    
}

-(void)modifyUserName:(NSString*)username andSELF:(id)selfy{
    
    //shared instance from memory!!!!
    User *user = [User sharedInstance];
    
     NSLog(@"==========shared instance==========");
    NSLog(@"%@",user.Uid);
    NSLog(@"%@",user.Uname);
    NSLog(@"%@",user.Upwd);
    NSLog(@"%d",user.Utype);
    NSLog(@"%@",user.Uselfie);
    
    
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:user.Uid, @"uid",user.Uname, @"old_uname", username, @"new_uname", nil];
    NSURL *url = [NSURL URLWithString:updatePROFILE];
    
    [self performAsyncTask:selfy andDictionary:dict andURL:url];

}


/************************

    Shared method (post)
 
 ************************/
-(void)performAsyncTask:(id)selfy andDictionary:(NSDictionary *)dict andURL:(NSURL *)url{
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
