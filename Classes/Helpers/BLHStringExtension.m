//
//  BLHStringExtension.m
//  yssy
//
//  Created by Rurui Ye on 1/30/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHStringExtension.h"

@implementation NSString (util)

- (int) indexOf:(NSString *)text{
    NSRange range = [self rangeOfString:text];
    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}

- (int) indexOf:(NSString *)text atRange:(NSRange)searchRange{
    NSRange range = [self rangeOfString:text options:0 range:searchRange];
    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}
@end