//
//  BLHContentCell.h
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLHContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView  *containerView;

@property (weak, nonatomic) IBOutlet NSString *file;
@property (weak, nonatomic) IBOutlet NSString *board;
-(void) setupContent: (NSArray*) contents;
@end
