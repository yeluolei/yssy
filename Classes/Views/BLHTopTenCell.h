//
//  BLHTopTenCell.h
//  yssy
//
//  Created by Rurui Ye on 1/31/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLHPaddingLabel.h"

@interface BLHTopTenCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *board;
@property (weak, nonatomic) IBOutlet BLHPaddingLabel *author;

-(void)setInitValue:(NSString *)title andBoard:(NSString*)board andAuthor:(NSString*) author;
@end
