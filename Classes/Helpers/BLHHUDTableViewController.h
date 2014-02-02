//
//  BLHHUDTableViewController.h
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BLHHUDTableViewController : UITableViewController <MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

- (void)showAlertLabel:(NSString*)label;
- (void)showHUDWhileExecuting:(SEL)method;
@end
