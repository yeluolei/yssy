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
#import "BLHContent.h"
#import "BLHContentCell.h"
#import "BLHColorHelper.h"

static NSString *CellIdentifier = @"ArticleCell";
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
    BLHContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    for (UIView *subV in [cell.containerView subviews]){
        [subV removeFromSuperview];
    }
    
    if (cell == nil)
    {
        cell = [[BLHContentCell alloc]init];
    }
    
    BLHArticle* article = self.articles[indexPath.row];
    // Configure the cell...
    cell.author.text = article.author;
    cell.author.backgroundColor = [UIColor getColorForLable:article.author];
    cell.time.text = article.file.time;
    [cell setupContent:article.file.content];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    BLHContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UIView *subV in [cell.containerView subviews]){
        [subV removeFromSuperview];
    }
    // Configure the cell for this indexPath
    BLHArticle* article = self.articles[indexPath.row];
    cell.author.text = article.author;
    cell.time.text = article.file.time;
    [cell setupContent:article.file.content];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct height for different table view widths, since our cell's height depends on its width due to
    // the multi-line UILabel word wrapping. Don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;*/
    return 50;

    
    /*BLHArticle* article = self.articles[indexPath.row];
    NSString *cellText  = ((BLHContent*)article.file.content[0]).content;
    //set the desired size of your textbox
    CGSize constraint = CGSizeMake(290, MAXFLOAT);
    //set your text attribute dictionary
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17.0] forKey:NSFontAttributeName];
    //get the size of the text box
    CGRect textsize = [cellText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //calculate your size
    float textHeight = textsize.size.height +20;
    //I have mine set for a minimum size
    textHeight = (textHeight < 50.0) ? 50.0 : textHeight;
    
    return textHeight;*/

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
