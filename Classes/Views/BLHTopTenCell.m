//
//  BLHTopTenCell.m
//  yssy
//
//  Created by Rurui Ye on 1/31/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHTopTenCell.h"
#import "UIColor+iOS7Colors.h"
#import "BLHColorHelper.h"

@interface BLHTopTenCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@end

@implementation BLHTopTenCell
@synthesize title = _title;
@synthesize board = _board;
@synthesize author = _author;

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
    [[NSBundle mainBundle] loadNibNamed:@"TopTenCell" owner:self options:nil];
    [self addSubview:self.view];
    self.author.layer.cornerRadius = 3;
}

-(void)setInitValue:(NSString *)title andBoard:(NSString*)board andAuthor:(NSString*) author
{
    if (title == nil || title.length == 0){
        title = @"Yssy";
    }
    self.author.text = author;
    self.author.backgroundColor = [UIColor getColorForLable:author];
    self.title.text = title;
    self.board.text = board;
    self.board.textColor = [UIColor getColorForLable:board];

}

@end
