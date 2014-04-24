//
//  User.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/8/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "User.h"

@implementation User

//static init
+ (User *)sharedInstanceWithUid:(NSString*)uid andUname:(NSString*)uname andUtype:(NSUInteger)utype andUselfie:(NSData*)uselfie
{
    // 1
    static User *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[User alloc] init];
        
        _sharedInstance.Uid = uid;
        _sharedInstance.Uname = uname;
        _sharedInstance.Utype = utype;
        _sharedInstance.Uselfie = uselfie;
    });
    return _sharedInstance;
}


// There’s a lot going on in this short method:
// Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
// Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
// Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of LibraryAPI.
// This is the essence of the Singleton design pattern: the initializer is never called again once the class has been instantiated.

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSString *)description   //toString description
{
	NSString *desc  = [NSString stringWithFormat:@"Uid: %@,Uname: %@,Utype: %i,Uselfie: %@", self.Uid, self.Uname, self.Utype, self.Uselfie];
	
	return desc;
}

@end
