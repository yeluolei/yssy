//
//  BLHLoginViewController.m
//  yssy
//
//  Created by Rurui Ye on 1/27/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHLoginViewController.h"
#import "BLHNetworkHelper.h"
#import "TFHpple.h"
#import "MBProgressHUD.h"

@interface BLHLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation BLHLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Custom initialization
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonClick:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BLHNetworkHelper *net = [[BLHNetworkHelper alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.userNameTextField.text forKey:@"id"];
    [params setObject:self.passwordTextField.text forKey:@"pw"];
    [params setObject:@"login" forKey:@"submit"];
    [net postRequest:@"https://bbs.sjtu.edu.cn/bbslogin" andParams: params onCompletion:^(NSDictionary* result) {
        if (![result objectForKey:@"error"]){
            // success
            NSString* content = [BLHNetworkHelper convertResponseToString: [result objectForKey:@"data"]];
            if ([content rangeOfString:@"出错啦"].location == NSNotFound)
            {
                NSLog(@"Login Successed");
                
            }
            else
            {
                TFHpple * doc = [[TFHpple alloc] initWithHTMLData:[result objectForKey:@"data"]];
                TFHppleElement * e = [doc peekAtSearchWithXPathQuery:@"/html/body/b"];
                NSLog(@"Login Failed With User Error: %@", e.text);
            }
        }
        else
        {
            // failed
            NSLog(@"Login Failed: %@", [result objectForKey:@"error"]);
        }
    }];
    [MBProgressHUD hideHUDForView:self.view animated:true];
}
@end
