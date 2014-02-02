//
//  BLHThread.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHFile.h"

@implementation BLHFile

-(id)init
{
    self = [super init];
    if(self)
    {
        self.content = [[NSMutableArray alloc]init];
    }
    return self;
}
@end
