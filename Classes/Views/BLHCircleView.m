//
//  BLHCircleView.m
//  yssy
//
//  Created by Rurui Ye on 12/21/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHCircleView.h"

@implementation BLHCircleViewOwner
@end

@class BLHCircleView;

@interface BLHCircleView ()
@end

@implementation BLHCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.backgroundColor setFill];
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextSetAlpha(context, 0.5);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
    
    CGContextSetStrokeColorWithColor(context, self.backgroundColor.CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
}

+(void)presentInViewController:(UIViewController*) viewController
{
    //Instantiating encapsulated here.
    BLHCircleViewOwner *owner = [BLHCircleViewOwner new];
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil];
    
    //Pass in a reference of the viewController.
    owner.decoupledView.delegate = (id)viewController;
    
    //Add (thus retain).
    [viewController.view addSubview:owner.decoupledView];
}

-(IBAction)viewTouchedUp
{
    //Forward to delegate.
    [self.delegate decoupledViewTouchedUp:self];
}
@end
