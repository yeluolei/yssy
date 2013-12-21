//
//  BLHMenuViewController.m
//  yssy
//
//  Created by Rurui Ye on 12/19/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHMenuViewController.h"
#import "SideMenuButton.h"
#import "BLHCircleView.h"

#define ButtonWidth 180
#define ButtonHeight 50

@interface BLHMenuViewController ()
@property (nonatomic) UIImageView *backgroundImageView;
@end

@implementation BLHMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            }
    return self;
}

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

    
    //BLHCircleView *label = [[BLHCircleView alloc]init];
    //[label setBackgroundColor:[UIColor blueColor]];
    
    //label.frame = CGRectMake(40, 50, 100, 100);
    //[self.view addSubview:label];
    
    NSArray * modeList = @[@"一",@"二"];
    for (NSInteger i = 0; i < modeList.count; i++)
    {
        UIButton *cmButton = [self createMenuButton:modeList[i]];
        cmButton.frame = CGRectMake(0, 140+i*ButtonHeight, ButtonWidth, ButtonHeight);
        [self.view addSubview:cmButton];
    }
	// Do any additional setup after loading the view.
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
@end
