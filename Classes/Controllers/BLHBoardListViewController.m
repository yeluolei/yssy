//
//  BLHBoardListViewController.m
//  yssy
//
//  Created by Rurui Ye on 2/2/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "BLHBoardListViewController.h"
#import "BLHSideMenuViewController.h"
#import "BLHThreadListViewController.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "BLHNetworkHelper.h"
#import "BLHColorHelper.h"
#import "BLHBoard.h"
#define IS_IOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

@interface BLHBoardListViewController ()
@property (nonatomic) NSMutableArray *allBoards;
@property (nonatomic) NSMutableArray *allBoardsWithSections;
@property (nonatomic) NSArray *searchResults;
@property (nonatomic) UILocalizedIndexedCollation *collation;
@end

@implementation BLHBoardListViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.searchDisplayController.displaysSearchBarInNavigationBar = YES;
    // if IOS 7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
     __weak BLHBoardListViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
    }];
    [self.tableView triggerPullToRefresh];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) refreshData
{
    self.allBoards = [[NSMutableArray alloc]init];
    [self loadBoards];
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
                [self configureSections];
                [self.tableView reloadData];
            }
        }
        else
        {
            // failed
            NSLog(@"Get Failed: %@", [result objectForKey:@"error"]);
            //[weakSelf showAlertLabel:[result objectForKey:@"error"]];
        }
        [self.tableView.pullToRefreshView stopAnimating];
    }];
}

-(void) configureSections
{
    self.collation = [UILocalizedIndexedCollation currentCollation];
    
	NSInteger index, sectionTitlesCount = [[self.collation sectionTitles] count];
    
	NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
	// Set up the sections array: elements are mutable arrays that will contain the time zones for that section.
	for (index = 0; index < sectionTitlesCount; index++) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[newSectionsArray addObject:array];
	}
    
	// Segregate the time zones into the appropriate arrays.
	for (BLHBoard *board in self.allBoards) {
        
		// Ask the collation which section number the time zone belongs in, based on its locale name.
		NSInteger sectionNumber = [self.collation sectionForObject:board collationStringSelector:@selector(name)];
        
		// Get the array for the section.
		NSMutableArray *section = newSectionsArray[sectionNumber];
        
		//  Add the time zone to the section.
		[section addObject:board];
	}
    
	// Now that all the data's in place, each section array needs to be sorted.
	for (index = 0; index < sectionTitlesCount; index++) {
        
		NSMutableArray *boardsArrayForSection = newSectionsArray[index];
        
		// If the table view or its contents were editable, you would make a mutable copy here.
		NSArray *sortedBoardArrayForSection = [self.collation sortedArrayFromArray:boardsArrayForSection collationStringSelector:@selector(name)];
        
		// Replace the existing array with the sorted array.
		newSectionsArray[index] = sortedBoardArrayForSection;
	}
    
	self.allBoardsWithSections = newSectionsArray;
}

- (IBAction)openMenu:(id)sender {
    [self.sideMenuViewController toggleMenuAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma search bar
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"SELF.name contains[c] %@",
                              searchText];
    self.searchResults = [self.allBoards filteredArrayUsingPredicate:predicate];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
        return self.collation.sectionTitles.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return  self.searchResults.count;
    }
    else{
        return [self.allBoardsWithSections[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BoardCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }

    BLHBoard* current = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        current = self.searchResults[indexPath.row];
    }
    else
    {
        current = self.allBoardsWithSections[indexPath.section][indexPath.row];
    }
    cell.textLabel.text = current.name;
    cell.textLabel.textColor = [UIColor getColorForLable:current.name];
    return cell;
    // Configure the cell...
}

/*
 Section-related methods: Retrieve the section titles and section index titles from the collation.
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    else{
        return [self.collation sectionTitles][section];
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    else{
        return [self.collation sectionIndexTitles];
    }
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    else{
        return [self.collation sectionForSectionIndexTitleAtIndex:index];
    }
    
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[BLHNetworkHelper manager].operationQueue cancelAllOperations];
    if([sender isKindOfClass:[UITableViewCell class]]) {
        BLHThreadListViewController* threadController = (BLHThreadListViewController*)[segue destinationViewController];
        if (self.searchDisplayController.active) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            BLHBoard *object = ((NSArray*)self.searchResults)[indexPath.row];
            threadController.boardName = object.name;
        }else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            BLHBoard *object = ((NSArray*)self.allBoardsWithSections[indexPath.section])[indexPath.row];
            threadController.boardName = object.name;
        }
        //Your code here
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
