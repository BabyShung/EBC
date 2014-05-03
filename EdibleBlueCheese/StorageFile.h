//
//  StorageFile.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 5/3/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageFile : NSObject

-(void)storeAsLocalFile:(NSData *)data andFileName:(NSString*) name;

-(NSData *)readDataFromLocalDocument:(NSString*)fileName;

@end
