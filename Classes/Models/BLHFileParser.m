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
@implementation BLHFileParser
-(BLHFile*)parser:(NSDictionary *)result
{
    if (![result objectForKey:@"error"]){
        NSDictionary *content = [result objectForKey:@"data"];
        if (content != nil)
        {
            BLHFile* file =  [[BLHFile alloc]init];
            NSDictionary* fileContent = [content objectForKey:@"content"];
            
            file.nick = [fileContent objectForKey:@"nick"];
            file.author = [fileContent objectForKey:@"author"];
            file.time = [self createDate:[fileContent objectForKey:@"datetime_tuple"]];
            // TODO add more parser to get images from this content
            BLHContent* content = [[BLHContent alloc]init];
            content.type = [TYPE_STRING copy];
            content.content =[fileContent objectForKey:@"text_lines"];
            [file.content addObject: content];
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

-(NSString*) createDate:(NSArray* )dateTuple
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:dateTuple[0]];
    [components setMonth:dateTuple[1]];
    [components setDay:dateTuple[2]];
    [components setHour:dateTuple[3]];
    [components setMinute:dateTuple[4]];
    [components setSecond:dateTuple[5]];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [format stringFromDate:date];
}
@end
