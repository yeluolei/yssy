//
//  BLHContent.h
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString* TYPE_STRING = @"string";
static const NSString* TYPE_IMAGE = @"image";
static const NSString* TYPE_REFRENCE = @"ref";

@interface BLHContent : NSObject
@property NSString* type;
@property NSString* content;
@end
