//
//  BLHContentCell.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHContentCell.h"
#import "BLHContent.h"
#import "BLHPaddingLabel.h"
#import "UIView+AutoLayout.h"


@interface BLHContentCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation BLHContentCell
@synthesize author = _author;
@synthesize time = _time;
@synthesize containerView = _containerView;
@synthesize file = _file;
@synthesize board = _board;

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

-(void) setupContent:(NSArray *)contents
{
    for (BLHContent* content in contents) {
        if (content.type == TYPE_STRING)
        {
            UILabel* label = [[UILabel alloc]init];
            label.numberOfLines = 0;
            label.text = content.content;
            [self.containerView addSubview:label];
        }
        else if (content.type == TYPE_REFRENCE)
        {
            BLHPaddingLabel* label = [[BLHPaddingLabel alloc]init];
            label.numberOfLines = 0;
            label.text = content.content;
            label.textColor = [UIColor grayColor];
            [self.containerView addSubview:label];
            
        }
        else if (content.type == TYPE_IMAGE)
        {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blur"]];
            [self.containerView addSubview:imageView];
        }
    }
}

-(void) updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) {
        return;
    }
    /*
    NSArray* subviews = [self.containerView subviews];
    UIView* preView;
    for (int i = 0 ; i < subviews.count; i++) {
        UIView* subview = subviews[i];
        if (i == 0)
        {
            [subview setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        }
        else if (i == subviews.count - 1)
        {
            [subview setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            [subview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:preView withOffset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        }
        else
        {
            [subview setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
            [subview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        }
        preView = subview;
    }*/
    self.didSetupConstraints = YES;
}
-(void) layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    [self.containerView setNeedsLayout];
    [self.containerView layoutIfNeeded];
}

-(void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"BLHContentCell" owner:self options:nil];
    [self addSubview:self.view];
    self.author.layer.cornerRadius = 3;
    self.author.textColor = [UIColor whiteColor];
}

@end
