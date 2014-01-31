//
//  BLHMasterViewController.m
//  yssy
//
//  Created by Rurui Ye on 1/20/13.
//  Copyright (c) 2013 Rurui Ye. All rights reserved.
//

#import "BLHMasterViewController.h"
#import "BLHThreadViewController.h"
#import "BLHSideMenuViewController.h"
#import "BLHNetworkHelper.h"
#import "MBProgressHUD.h"
#import "BLHTopTenList.h"
#import "BLHTopTenCell.h"

@interface BLHMasterViewController () {
    NSArray *_objects;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuNavBarButton;
@end

@implementation BLHMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BLHNetworkHelper * net = [[BLHNetworkHelper alloc]init];
    
    [net getContent:@"http://bbs.sjtu.edu.cn/file/bbs/mobile/top100.html" onCompletion:^(NSDictionary *result) {
        if (![result objectForKey:@"error"]){
            NSString *content = [BLHNetworkHelper convertResponseToString: [result objectForKey:@"data"]];
            //NSLog(@"Get success: %@", content);
            if (content != nil)
            {
                BLHTopTenList* topTenList = [[BLHTopTenList alloc]init];
                [topTenList parse:content];
                _objects = [topTenList getPostItems];
                [self.tableView reloadData];
            }
            //NSLog(@"%@", [[NSString alloc] initWithData:(NSData*)responseObject encoding:NSASCIIStringEncoding]);
        }
        else
        {
            // failed
            NSLog(@"Get Failed: %@", [result objectForKey:@"error"]);
            [[[MBProgressHUD alloc]init] showAnimated:true whileExecutingBlock:^{
                
            }];
        }
    }];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
}

- (IBAction)openMenu:(id)sender {
    [self.sideMenuViewController toggleMenuAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *topTenCell = @"TopTenCell";
    
    BLHTopTenCell *cell = (BLHTopTenCell *)[tableView dequeueReusableCellWithIdentifier:topTenCell];
    if (cell == nil)
    {
        cell = [[BLHTopTenCell alloc] init];
    }
    
    NSDictionary *object = _objects[indexPath.row];
    [cell setInitValue:[object valueForKey:@"Title"] andBoard:[object valueForKey:@"Board"] andAuthor:[object valueForKey:@"AuthorID"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showThread"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = (NSDictionary*)_objects[indexPath.row];
        BLHThreadViewController* threadController = (BLHThreadViewController*)[segue destinationViewController];
        threadController.params = object;
    }
}

@end
