//
//  LoginRegister.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "AsyncRequest.h"
#import "User.h"
#import "edi_md5.h"


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
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:user.Uid, @"uid",user.Uname, @"old_uname", username, @"new_uname", nil];
    NSURL *url = [NSURL URLWithString:updatePROFILE];
    
    [self performAsyncTask:selfy andDictionary:dict andURL:url];

}

/******************
 
 search user
 
 ******************/
-(void)searchUser:(NSString*)oldpwd andNextPwd:(NSString*)nextpwd andConfirmPwd:(NSString*)confirmpwd andSELF:(id)selfy{
    
    //ready to md5 all the passwords
//    edi_md5* edimd5 = [[edi_md5 alloc]init];
//    
//    
//    
//    //shared instance from memory!!!!
//    User *user = [User sharedInstance];
//    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:user.Uid, @"uid",[edimd5 md5:oldpwd], @"old_upwd", [edimd5 md5:nextpwd], @"new_upwd", [edimd5 md5:confirmpwd], @"new_upwd_retype", nil];
//    NSURL *url = [NSURL URLWithString:changePASSWORD];
//    
//    [self performAsyncTask:selfy andDictionary:dict andURL:url];
//    
    
}

/******************

 change PWD
 
******************/
-(void)modifyPWD_oldPwd:(NSString*)oldpwd andNextPwd:(NSString*)nextpwd andConfirmPwd:(NSString*)confirmpwd andSELF:(id)selfy{
    
    //ready to md5 all the passwords
    edi_md5* edimd5 = [[edi_md5 alloc]init];
    
    
    
    //shared instance from memory!!!!
    User *user = [User sharedInstance];
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:user.Uid, @"uid",[edimd5 md5:oldpwd], @"old_upwd", [edimd5 md5:nextpwd], @"new_upwd", [edimd5 md5:confirmpwd], @"new_upwd_retype", nil];
    NSURL *url = [NSURL URLWithString:changePASSWORD];
    
    [self performAsyncTask:selfy andDictionary:dict andURL:url];

    
}

-(void)changeSelfie_Selfie:(NSData *) imageData andSELF:(id)selfy{
    //shared instance from memory!!!!
    User *user = [User sharedInstance];
    
    NSLog(@"imageData ???  %@",imageData);

    
    const unsigned char *bytess = [[imageData base64EncodedDataWithOptions:NSUTF8StringEncoding] bytes]; // no need to copy the data
    NSUInteger length = [imageData length];
    NSMutableArray *byteArray = [NSMutableArray array];

    for (NSUInteger i = 0; i < length; i++) {
        
        //[byteArray addObject:[NSNumber numberWithUnsignedChar:bytess[i]]];
        [byteArray addObject:[NSString stringWithFormat:@"%d",bytess[i]]];
        //[NSString stringWithFormat:@"%c",bytess[i]]
    }

    
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:user.Uid, @"uid",byteArray, @"uselfie", nil];
    NSURL *url = [NSURL URLWithString:changeSELFIE];
    
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
