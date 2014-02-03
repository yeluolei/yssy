//
//  BLHMenuViewController.m
//  yssy
//
//  Created by Rurui Ye on 12/19/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHMenuViewController.h"
#import "BLHSideMenuViewController.h"
#import "SideMenuButton.h"
#import "BLHCircleView.h"
#import "BLHMainNavViewController.h"
#import "BLHReplyMeViewController.h"
#import "BLHMasterViewController.h"

#define ButtonWidth 180
#define ButtonHeight 50

@interface BLHMenuViewController ()
@property (nonatomic) UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet BLHCircleView *idLabelView;

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *firstTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *secondTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *thirdTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *fourthTableViewCell;

@end

@implementation BLHMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"galaxy"]];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    [self.view sendSubviewToBack:(self.backgroundImageView)];

    [self.idLabelView setInitValue:@"Try" andBackground:[UIColor redColor]];
}

- (UIButton*)createMenuButton:(NSString*) label
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:label forState:UIControlStateNormal];
    return button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)unwindToMenu:(UIStoryboardSegue *)segue
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.firstTableViewCell;
            break;
        case 1:
            cell = self.secondTableViewCell;
            break;
        case 2:
            cell = self.thirdTableViewCell;
            break;
        case 3:
            cell = self.fourthTableViewCell;
            break;
        default:
        cell = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // TODO 怎么new一个controller放在这里切换。。
    UIViewController *controller;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
            controller = [(BLHMainNavViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MainNavView"] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"]];
            break;
        }
        case 1:
        {
            controller = [(BLHMainNavViewController*)[storyboard instantiateViewControllerWithIdentifier:@"BoardListNavView"] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"BoardListViewController"]];
            break;
        }
        case 2:
        {
            controller = [(BLHMainNavViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ReplyMeNav"] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"ReplyMeViewController"]];
            break;
        }
        case 3:
            break;
        default:
        break;
    }
    if (controller != nil){
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    }
    //UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[ new]];
        //BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
    //trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
    //[[self navigationController] pushViewController:trailsController animated:YES];
}
@end
