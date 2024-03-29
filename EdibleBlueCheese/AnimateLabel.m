//
//  ATLabel.m
//
// Created by Karthikeya Udupa on 7/14/13.
// Copyright (c) 2012 Karthikeya Udupa K M All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "AnimateLabel.h"

@implementation AnimateLabel
@synthesize wordList = _wordList;
@synthesize duration = _duration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)animateWithWords:(NSArray *)words forDuration:(double)time {
    self.duration = time;
    if(self.wordList){
        self.wordList = nil;
    }
    self.wordList = [[NSArray alloc] initWithArray:words];
    self.text = [self.wordList objectAtIndex:0];
    [NSThread detachNewThreadSelector:@selector(_startAnimations:) toTarget:self withObject:self.wordList];
    
}

- (void) _startAnimations:(NSArray *)images {
    
    @autoreleasepool {
        
        for (uint i = 1; i < [images count]; i++) {
            sleep(self.duration);
            [self performSelectorOnMainThread:@selector(_animate:)
                                   withObject:[NSNumber numberWithInt:i]
                                waitUntilDone:YES];
            
            sleep(self.duration);
            if (i == [images count] - 1) {
                i = -1;
            }
        }
    
}
}


- (void) _animate:(NSNumber*)num
{
    
    [UIView animateWithDuration:self.duration/2 animations:^{
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:self.duration/2 animations:^{
            self.alpha = 1.0;
            self.text = [self.wordList objectAtIndex:[num intValue]];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

@end
