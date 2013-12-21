//
//  AppDelegate.m
//  yssy
//
//  Created by Rurui Ye on 1/20/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHAppDelegate.h"
#import "BLHSideMenuViewController.h"
#import "BLHMasterViewController.h"
#import "BLHMenuViewController.h"
#import "BLHMainNavViewController.h"

@interface BLHAppDelegate()
@property (nonatomic, strong) BLHSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) BLHMenuViewController *menuViewController;
@property (nonatomic, strong) BLHMasterViewController *mainViewController;
@end

@implementation BLHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.menuViewController = (BLHMenuViewController *)[sb instantiateViewControllerWithIdentifier:@"MenuView"];
    self.mainViewController = (BLHMasterViewController *)[sb instantiateViewControllerWithIdentifier:@"MasterView"];
    
    self.sideMenuViewController = [[BLHSideMenuViewController alloc] initWithMenuViewController:self.menuViewController mainViewController: [(BLHMainNavViewController*)[sb instantiateViewControllerWithIdentifier:@"MainNavView"] initWithRootViewController:self.mainViewController ]];
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 14.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.8 : 0.6;//0.5634f : 0.85f;
    self.window.rootViewController = self.sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*
- (UIStatusBarStyle)sideMenuViewController:(BLHSideMenuViewController *)sideMenuViewController statusBarStyleForViewController:(UIViewController *)viewController
{
    if (viewController == self.menuViewController) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}*/

@end
