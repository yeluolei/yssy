//
//  BLHHUDTableViewController.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHHUDTableViewController.h"

@interface BLHHUDTableViewController ()

@end

@implementation BLHHUDTableViewController

-(void) showAlertLabel:(NSString *)label
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = label;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
    
	[hud hide:YES afterDelay:3];
}

-(void) showHUDWhileExecuting:(SEL)method
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
    
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];

}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
