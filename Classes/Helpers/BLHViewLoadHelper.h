//
//  BLHViewLoadHelper.h
//  yssy
//
//  Created by Rurui Ye on 12/21/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLHViewLoadHelper : NSObject
@property (nonatomic, strong) IBOutlet UIView *view;
+(id)viewFromNibNamed:(NSString*) nibName;
@end


@interface UIView (Instantiate)
+(id)loadFromNib;
+(id)loadFromNibNamed:(NSString*) nibName;
@end

