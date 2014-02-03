//
//  BLHThreadParser.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHFileParser.h"
#import "BLHNetworkHelper.h"
#import "BLHContent.h"
#import "BLHStringExtension.h"
@implementation BLHFileParser
-(BLHFile*)parser:(NSDictionary *)result
{
    if (![result objectForKey:@"error"]){
        NSDictionary *contentJson = [result objectForKey:@"data"];
        if (contentJson != nil)
        {
            BLHFile* file =  [[BLHFile alloc]init];
            NSDictionary* fileContentJson = [contentJson objectForKey:@"content"];
            
            file.nick = [fileContentJson objectForKey:@"nick"];
            file.author = [fileContentJson objectForKey:@"author"];
            file.time = [self createDate:[fileContentJson objectForKey:@"datetime_tuple"]];
            // TODO add more parser to get images from this content
            file.content = [self parseContent:[fileContentJson objectForKey:@"text_lines"]];
            [file.content addObjectsFromArray: [self parseRef:[fileContentJson objectForKey:@"reply_lines"]]];
            return file;
            //[self.tableView reloadData];
        }
    }
    else
    {
        // failed
        NSLog(@"Get Failed: %@", [result objectForKey:@"error"]);
    }
    return nil;
}

-(NSMutableArray*) parseContent:(NSArray*) objects
{
    NSMutableArray* texts = [[NSMutableArray alloc]init];
    NSString* line = @"";
    NSString* tmp = @"";
    for (NSString* object in objects) {
        
        // escape refrence
        if ([object hasPrefix:@"<font color=\"808080\">"])
            break;
        
        int imgpos = [object indexOf:@"<img"];
        if(imgpos != -1)// found image
        {
            // cut pre part and add to pre
            
        }
        else{
            line = [line stringByAppendingString:[tmp stringByAppendingString:@"\n" ]];
            tmp = [object stringByStrippingHTML];
        }
    }
    BLHContent* content = [[BLHContent alloc]init];
    content.type = [TYPE_STRING copy];
    content.content = [line stringByStrippingHTML];
    [texts addObject:content];
    return texts;
}

-(NSMutableArray*) parseRef:(NSArray*) refs
{
    NSMutableArray* texts = [[NSMutableArray alloc]init];
    NSString* line = [[NSString alloc] init];
    NSString* tmp = @"";
    for (NSString* object in refs) {
        if ([object hasPrefix:@": "])
        {
            break;
        }
        line = [line stringByAppendingString:[tmp stringByAppendingString:@"\n" ]];
        tmp = [object stringByStrippingHTML];
    }
    BLHContent* content = [[BLHContent alloc]init];
    content.type = [TYPE_STRING copy];
    content.content = [line stringByStrippingHTML];
    return texts;
}

-(NSString*) createDate:(NSArray* )dateTuple
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSLog(@"%@",dateTuple[0]);
    [components setYear:[dateTuple[0] integerValue]];
    [components setMonth:dateTuple[1]];
    [components setDay:dateTuple[2]];
    [components setHour:dateTuple[3]];
    [components setMinute:dateTuple[4]];
    [components setSecond:dateTuple[5]];
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];
    [cal setLocale:[NSLocale currentLocale]];
    NSDate *date = [cal dateFromComponents:components];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [format stringFromDate:date];
}
@end
