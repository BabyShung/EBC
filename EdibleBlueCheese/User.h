//
//  User.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *Uid; //email
@property (nonatomic, retain) NSString *Uname;
@property (nonatomic, assign) NSUInteger Utype;
@property (nonatomic, retain) NSData *Uselfie;


+ (User *)sharedInstanceWithUid:(NSString*)uid andUname:(NSString*)uname andUtype:(NSUInteger)utype andUselfie:(NSData*)uselfie;

@end
