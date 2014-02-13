//
//  BLHSearchDisplayController.m
//  yssy
//
//  Created by Rurui Ye on 2/14/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHSearchDisplayController.h"

@implementation BLHSearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    if(self.active == visible) return;
    [self.searchContentsController.navigationController setNavigationBarHidden:YES animated:NO];
    [super setActive:visible animated:animated];
    [self.searchContentsController.navigationController setNavigationBarHidden:NO animated:NO];
    if (visible) {
        [self.searchBar becomeFirstResponder];
    } else {
        [self.searchBar resignFirstResponder];
    }
}

@end
