//
//  BLHCircleView.m
//  yssy
//
//  Created by Rurui Ye on 12/21/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHCircleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BLHCircleView

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
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"CircleLabelView" owner:self options:nil];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.view];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Our WidgetView is a UIView that contains a UIView, we need to establish
    //  the relation with autolayout. We'll want the self.view to be 200x100 pixels
    //  and we'll have the superview (WidgetView) stick to the edges (i.e. same size).
    
    // width and edges   H:|[self.view(200)]|
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_view(100)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_view, self)]];
    
    // height and edges   V:|[self.view(100)]|
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_view(100)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_view, self)]];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor redColor] CGColor]));
    CGContextFillPath(ctx);
}

/*
-(IBAction)viewTouchedUp
{
    //Forward to delegate.
    [self.delegate decoupledViewTouchedUp:self];
}*/
@end
