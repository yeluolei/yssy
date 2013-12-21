//
//  com_yrr_bbsDetailViewController.h
//  yssy
//
//  Created by Rurui Ye on 1/20/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLHDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
