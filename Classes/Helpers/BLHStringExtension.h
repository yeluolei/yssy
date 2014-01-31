//
//  BLHStringExtension.h
//  yssy
//
//  Created by Rurui Ye on 1/30/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (util)

- (int) indexOf:(NSString *)text;
- (int) indexOf:(NSString *)text atRange:(NSRange)searchRange;

@end
