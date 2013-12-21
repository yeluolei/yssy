//
//  BLHViewLoadHelper.m
//  yssy
//
//  Created by Rurui Ye on 12/21/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHViewLoadHelper.h"

@implementation BLHViewLoadHelper

+(id)viewFromNibNamed:(NSString*) nibName
{
    BLHViewLoadHelper *instantiator = [self new];
    [[NSBundle mainBundle] loadNibNamed:nibName owner:instantiator options:nil];
    return instantiator.view;
}

@end


@implementation UIView (Instantiate)

+(id)loadFromNib
{ return [self loadFromNibNamed:NSStringFromClass(self)]; }

+(id)loadFromNibNamed:(NSString*) nibName
{ return [BLHViewLoadHelper viewFromNibNamed:nibName]; }

@end