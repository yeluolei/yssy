//
//  BLHTopTenLocalizedIndexedCollation.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHTopTenLocalizedIndexedCollation.h"

@implementation BLHTopTenLocalizedIndexedCollation

-(id)init
{
    self = [super init];
    if (self)
    {
        self.sectionTitles = [NSArray arrayWithObjects:@"#",@"0",@"1",@"2","3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B", nil];
    }
    return self;
}
@end
