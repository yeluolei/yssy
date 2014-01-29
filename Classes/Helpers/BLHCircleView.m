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
    
    CGFloat factor = 1.0f;
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:self.circleLabel
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.circleLabel
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:factor
                                      constant:0];
    
    constraint.priority = 1000;
    [self.view addConstraint:constraint];
    
    [self addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[_view]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_view)]];
    [self addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[_view]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_view)]];

    //self.autoresizesSubviews = YES;
    //[self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    //self.circleLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    //self.circleLabel.layer.borderWidth = 1.0f;
    self.circleLabel.layer.cornerRadius = self.circleLabel.frame.size.height/2.0f;
}

-(void)setInitValue:(NSString *)label andBackground:(UIColor *)background
{
    if (label == nil || label.length == 0){
        label = @"Yssy";
    }
    
    NSString *left = [[label substringToIndex:1] uppercaseString];
    NSString *right = label;
    self.circleLabel.text = left;
    self.rightLabel.text = right;
    self.circleLabel.backgroundColor = background;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor redColor] CGColor]));
    CGContextFillPath(ctx);
}*/

/*
-(IBAction)viewTouchedUp
{
    //Forward to delegate.
    [self.delegate decoupledViewTouchedUp:self];
}*/
@end
