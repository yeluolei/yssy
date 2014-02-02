//
//  BLHThreadViewController.m
//  yssy
//
//  Created by Rurui Ye on 1/31/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHThreadViewController.h"
#import "BLHStringExtension.h"
#import "BLHNetworkHelper.h"
#import "BLHArticle.h"
#import "BLHFileParser.h"

@interface BLHThreadViewController ()
@property NSMutableArray* articles;
@end

@implementation BLHThreadViewController

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
    self.articles = [[NSMutableArray alloc]init];
    self.title = [self.params valueForKey:@"Title"];
    
    
    NSString* link = [self.params valueForKey:@"LinkURL"];
    NSString* thread =  [link substringFromIndex:[link indexOf:@"board"]];
    NSString* url = [@"https://bbs.sjtu.edu.cn/api/thread?" stringByAppendingString:thread];
    NSLog(@"%@",url);
    
    BLHFileParser * fileparser =[[BLHFileParser alloc]init];
    BLHNetworkHelper *net = [[BLHNetworkHelper alloc]init];
    
    
    [net getJsonContent:url onCompletion:^(NSDictionary *result) {
        if (![result objectForKey:@"error"]){
            NSDictionary *content = [result objectForKey:@"data"];
            //NSLog(@"Get success: %@", content);
            if (content != nil)
            {
                NSArray* articles = [content objectForKey:@"articles"];
                dispatch_group_t group = dispatch_group_create();
                
                for (NSDictionary* articleContent in articles) {
                    dispatch_group_enter(group);
                    BLHArticle* article = [[BLHArticle alloc]init];
                    article.author = [articleContent objectForKey:@"user"];
                    article.link = [NSString stringWithFormat:@"https://bbs.sjtu.edu.cn/api/article/%@/%@",[articleContent objectForKey:@"board"],[articleContent objectForKey:@"file"]];
                    [net getJsonContent:article.link onCompletion:^(NSDictionary *result) {
                        article.file = [fileparser parser:result];
                        [self.articles addObject:article];
                        dispatch_group_leave(group);
                    }];
                }
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
        else
        {
            // failed
            NSLog(@"Get Failed: %@", [result objectForKey:@"error"]);
            
            [self showAlertLabel:[result objectForKey:@"error"]];
        }

    }];
    
    [self.tableView reloadData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = ((BLHArticle*)self.articles[indexPath.row]).file.nick;
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
