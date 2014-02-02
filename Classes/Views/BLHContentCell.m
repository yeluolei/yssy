//
//  BLHContentCell.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHContentCell.h"

@interface BLHContentCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@end

@implementation BLHContentCell
@synthesize author = _author;
@synthesize time = _time;
@synthesize content = _content;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    //NSLog(@"top ten cell initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    //NSLog(@"top ten cell initWithCoder");
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.nameLeft.layer.cornerRadius = self.nameLeft.frame.size.height/2.0f;
        [self setup];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"BLHContentCell" owner:self options:nil];
    [self addSubview:self.view];
    self.author.layer.cornerRadius = 3;
}

@end
