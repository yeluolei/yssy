//
//  BLHThreadParser.h
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLHFile.h"
#import "BLHArticle.h"
@interface BLHFileParser : NSObject
-(BLHFile*) parser: (NSDictionary*) result;
@end
