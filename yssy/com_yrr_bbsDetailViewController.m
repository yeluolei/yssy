//
//  com_yrr_bbsDetailViewController.m
//  yssy
//
//  Created by Rurui Ye on 1/20/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "com_yrr_bbsDetailViewController.h"

@interface com_yrr_bbsDetailViewController ()
- (void)configureView;
@end

@implementation com_yrr_bbsDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
