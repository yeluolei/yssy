//
//  BLHReplyMeViewController.m
//  yssy
//
//  Created by Rurui Ye on 1/30/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHReplyMeViewController.h"
#import "BLHSideMenuViewController.h"
#import "BLHNetworkHelper.h"
#import "TFHpple.h"
#import "ReplyToMeItem.h"

@interface BLHReplyMeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuNavBarItem;
@property NSMutableArray *ReplyToMeItems;

@end

@implementation BLHReplyMeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)openMenu:(id)sender {
    [self.sideMenuViewController toggleMenuAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.ReplyToMeItems = [[NSMutableArray alloc] init];
    BLHNetworkHelper *net = [[BLHNetworkHelper alloc]init];
    [net sendRequest:@"https://bbs.sjtu.edu.cn/bbsreply" andParams: nil onCompletion:^(NSDictionary* result) {
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
            TFHpple * doc = [[TFHpple alloc] initWithHTMLData:[result objectForKey:@"data"]];
            NSArray * elements = [doc searchWithXPathQuery:@"/html/head/script"];
            TFHppleElement *e = elements.lastObject;
            e = e.children.firstObject;
            NSString *script = e.content;
            NSLog(@"script content: %@",script);
            NSInteger loc = [script rangeOfString:@"{"].location;
            if(loc != NSNotFound){
                NSString *jsonContent = [script substringWithRange:NSMakeRange(loc, script.length - loc - 1)];
                NSLog(@"Json content: %@", jsonContent);
                NSError *error = nil;
                NSData *data = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (!jsonDic) {
                    NSLog(@"Error parsing JSON: %@", error);
                } else {
                    NSArray *arr = [jsonDic objectForKey:@"items"];
                    for (NSDictionary *item in arr) {
                        ReplyToMeItem *tmp = [[ReplyToMeItem alloc] init];
                        
                        NSString *base64 =[item objectForKey:@"title"];
                        NSLog(@"item: %@", base64);
                        NSString *decodedString = [self convertBase64ToString:base64];
                        NSLog(@"string in item: %@", decodedString);
                        tmp.title = decodedString;
                        
                        
                        base64 =[item objectForKey:@"from_user"];
                        NSLog(@"item: %@", base64);
                        decodedString = [self convertBase64ToString:base64];
                        NSLog(@"string in item: %@", decodedString);
                        tmp.from = decodedString;
                        
                        base64 =[item objectForKey:@"board"];
                        NSLog(@"item: %@", base64);
                        decodedString = [self convertBase64ToString:base64];
                        NSLog(@"string in item: %@", decodedString);
                        tmp.board = decodedString;
                        
                        [self.ReplyToMeItems addObject:tmp];
                    }
                }
            }
            [self.tableView reloadData];
        }
        else
        {
            // failed
            NSLog(@"Login Failed: %@", [result objectForKey:@"error"]);
        }
    }];
}

- (NSString *)convertBase64ToString:(NSString *)str
{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:enc];
    NSLog(@"convertBase64Tostring: %@", decodedString);
    return decodedString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.ReplyToMeItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    ReplyToMeItem * item = [self.ReplyToMeItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    NSLog(@"fsadfasdfasdf");
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
