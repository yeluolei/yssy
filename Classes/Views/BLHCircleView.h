//
//  BLHCircleView.h
//  yssy
//
//  Created by Rurui Ye on 12/21/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLHCircleView;

@protocol BLHCircleViewDelegate<NSObject>
-(void)decoupledViewTouchedUp:(BLHCircleView*) decoupledView;
@end

@interface BLHCircleView : UIView
@property (assign) id<BLHCircleViewDelegate> delegate;
+(void)presentInViewController:(UIViewController*) viewController;
-(IBAction)viewTouchedUp;
@end