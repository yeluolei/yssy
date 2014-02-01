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
#import "BLHTopTenParser.h"
#import "BLHTopTenCell.h"
#import "BLHTopTenItem.h"

@interface BLHMasterViewController () {
    NSArray *_objects;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuNavBarButton;
@property (nonatomic) NSDictionary* sections;
@property (nonatomic) NSArray* sectionIndexs;
-(void) configSections;
@end

@implementation BLHMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sectionIndexs = @[@"#",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B"];
    
    self.sections = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"今日十大", @"#",
                     @"0区 BBS系统", @"0",
                     @"1区 上海交大", @"1",
                     @"2区 学子院校", @"2",
                     @"3区 电脑技术", @"3",
                     @"4区 学术科学", @"4",
                     @"5区 艺术文化", @"5",
                     @"6区 体育运动", @"6",
                     @"7区 休闲娱乐", @"7",
                     @"8区 知性感性", @"8",
                     @"9区 社会信息", @"9",
                     @"A区 社团群体", @"A",
                     @"B区 游戏专区", @"B",
                     nil];
    BLHNetworkHelper * net = [[BLHNetworkHelper alloc]init];
    
    [net getContent:@"https://bbs.sjtu.edu.cn/php/bbsindex.html" onCompletion:^(NSDictionary *result) {
        if (![result objectForKey:@"error"]){
            NSString *content = [BLHNetworkHelper convertResponseToString: [result objectForKey:@"data"]];
            //NSLog(@"Get success: %@", content);
            if (content != nil)
            {
                BLHTopTenParser* topTenList = [[BLHTopTenParser alloc]init];
                [topTenList parse:content];
                _objects = [topTenList getPostItems];
                [self configSections];
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
    return _objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)[_objects objectAtIndex:section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *topTenCell = @"TopTenCell";
    
    BLHTopTenCell *cell = (BLHTopTenCell *)[tableView dequeueReusableCellWithIdentifier:topTenCell];
    if (cell == nil)
    {
        cell = [[BLHTopTenCell alloc] init];
    }
    
    BLHTopTenItem *object = ((NSArray*)_objects[indexPath.section])[indexPath.row];
    [cell setInitValue:object.title andBoard:object.board andAuthor:object.author];
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
 Section-related methods: Retrieve the section titles and section index titles from the collation.
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sections objectForKey:self.sectionIndexs[section]];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexs;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

-(void) configSections
{
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
        BLHTopTenItem *object = ((NSArray*)_objects[indexPath.section])[indexPath.row];
        BLHThreadViewController* threadController = (BLHThreadViewController*)[segue destinationViewController];
        threadController.params = [NSDictionary dictionaryWithObjects:@[object.title,object.url] forKeys:@[@"Title",@"LinkURL"]];
    }
}

@end
