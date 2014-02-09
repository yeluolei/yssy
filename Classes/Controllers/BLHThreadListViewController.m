//
//  BLHThreadListViewController.m
//  yssy
//
//  Created by Rurui Ye on 2/7/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHThreadListViewController.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "BLHNetworkHelper.h"
#import "BLHBoardArticle.h"

@interface BLHThreadListViewController ()
@property (nonatomic) int currentPage;
@property (nonatomic) NSMutableArray* allArticles;
@end

@implementation BLHThreadListViewController

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
    self.title = self.boardName;
    self.currentPage = 0;
    // if IOS 7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    __weak BLHThreadListViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
    }];
    
    [self.tableView triggerPullToRefresh];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) refreshData
{
    [self loadThreadData:0];
}

-(void) loadThreadData: (int) page
{
    NSString* url = page==0? [NSString stringWithFormat:@"https://bbs.sjtu.edu.cn/api/board/%@",self.boardName]:
                        [NSString stringWithFormat:@"https://bbs.sjtu.edu.cn/api/board/%@?page=%d",self.boardName,page];
    __weak BLHThreadListViewController *weakSelf = self;
    BLHNetworkHelper* net = [[BLHNetworkHelper alloc]init];
    
    [net getJsonContent:url onCompletion:^(NSDictionary *result) {
        if (![result objectForKey:@"error"]){
            NSDictionary *contentJson = [result objectForKey:@"data"];
            //NSLog(@"Get success: %@", content);
            if (contentJson != nil)
            {
                weakSelf.currentPage = [contentJson objectForKey:@"page"];
                
                NSArray* articles = [contentJson objectForKey:@"articles"];
                for (NSDictionary* articleJson in articles) {
                    BLHBoardArticle* article = [[BLHBoardArticle alloc]init];
                    article.title = [articleJson objectForKey:@"board"];
                    article.author = [articleJson objectForKey:@"author"];
                    article.file = [articleJson objectForKey:@"file"];
                    [weakSelf.allArticles addObject:article];
                }
                [weakSelf.tableView reloadData];
            }
        }
        else
        {
            // failed
            NSLog(@"Get Failed: %@", [result objectForKey:@"error"]);
            [weakSelf showAlertLabel:[result objectForKey:@"error"]];
        }
        
        if (page == 0)
        {
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }
        else
        {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
