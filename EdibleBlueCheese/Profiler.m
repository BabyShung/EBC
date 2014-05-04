//
//  Profiler.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/4/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "Profiler.h"

@implementation Profiler

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithUid:(NSString *)uid andUname:(NSString *)uname andUtype:(NSUInteger)utype andUselfie:(NSData*)uselfie {
    
    if (self = [super init]) {
        self.Uid = uid;
        self.Uname = uname;
        self.Utype =utype;
        self.Uselfie = uselfie;
    }
    return self;
}


- (NSString *)description   //toString description
{
	NSString *desc  = [NSString stringWithFormat:@"Uid: %@, Uname: %@, Utype: %lu, Uselfie: %@", self.Uid, self.Uname, (unsigned long)self.Utype, self.Uselfie?@"Yes":@"Nil"];
	
	return desc;
}

@end
