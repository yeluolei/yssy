//
//  BLHBoardListViewController.m
//  yssy
//
//  Created by Rurui Ye on 2/2/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHBoardListViewController.h"
#import "BLHNetworkHelper.h"
#import "BLHColorHelper.h"
#import "BLHBoard.h"
#define IS_IOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

@interface BLHBoardListViewController ()
@property (nonatomic) NSMutableArray *allBoards;
@property (nonatomic) NSMutableArray *searchResults;
@end

@implementation BLHBoardListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchDisplayController.displaysSearchBarInNavigationBar = YES;
    self.allBoards = [[NSMutableArray alloc]init];
    [self loadBoards];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) loadBoards{
    BLHNetworkHelper* net = [[BLHNetworkHelper alloc]init];
    [net getJsonContent:@"https://bbs.sjtu.edu.cn/api/bbsall" onCompletion:^(NSDictionary *result) {
        if (![result objectForKey:@"error"]){
            NSDictionary *content = [result objectForKey:@"data"];
            //NSLog(@"Get success: %@", content);
            if (content != nil)
            {
                NSArray* boards = [content objectForKey:@"boards"];
                for (NSDictionary* boardJson in boards) {
                    BLHBoard* board = [[BLHBoard alloc]init];
                    board.name = [boardJson objectForKey:@"board"];
                    board.chinese = [boardJson objectForKey:@"chinese"];
                    board.category = [boardJson objectForKey:@"category"];
                    [self.allBoards addObject:board];
                }
                [self.tableView reloadData];
            }
        }
        else
        {
            // failed
            NSLog(@"Get Failed: %@", [result objectForKey:@"error"]);
            [self showAlertLabel:[result objectForKey:@"error"]];
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma search bar
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.allBoards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BoardCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }
    // Configure the cell...
    
    BLHBoard* current = self.allBoards[indexPath.row];
    
    cell.textLabel.text = current.name;
    cell.textLabel.textColor = [UIColor getColorForLable:current.name];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
