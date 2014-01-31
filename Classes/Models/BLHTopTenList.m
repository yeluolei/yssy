//
//  BLHTopTenList.m
//  yssy
//
//  Created by Rurui Ye on 1/30/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHTopTenList.h"
#import "BLHStringExtension.h"
@interface BLHTopTenList()
@end

@implementation BLHTopTenList

-(id)init
{
    self = [super init];
    if (self)
    {
        postItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) parse:(NSString *)content
{
    int pastpos = 1;
    int prepos = 0;
    for(int i= 0;i<10;i++)
    {
        pastpos  = [content indexOf:@"target" atRange:NSMakeRange(pastpos, content.length - pastpos)];
        NSMutableDictionary* postItem = [[NSMutableDictionary alloc]init];
        prepos  = [content indexOf:@">" atRange:NSMakeRange(pastpos, content.length - pastpos)];
        pastpos = [content indexOf:@"</" atRange:NSMakeRange(prepos, content.length - prepos)];
        NSString * board = [[content substringWithRange:NSMakeRange(prepos+1, pastpos - prepos - 1)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [postItem  setValue: board forKey:@"Board"];
        
        prepos = [content indexOf:@"href=\"" atRange:NSMakeRange(pastpos, content.length - pastpos)];
        pastpos =[content indexOf:@"\"" atRange: NSMakeRange(prepos+6, content.length - prepos - 6)];
        [postItem  setValue: [[content substringWithRange:NSMakeRange(prepos+6, pastpos - prepos - 6)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"LinkURL"];
        
        prepos  = [content indexOf:@">" atRange:NSMakeRange(pastpos, content.length - pastpos)];
        pastpos = [content indexOf:@"</" atRange:NSMakeRange(prepos, content.length - prepos)];
        [postItem  setValue: [[content substringWithRange:NSMakeRange(prepos+1, pastpos- prepos - 1)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"Title"];
        
        prepos  = [content indexOf:@">" atRange:NSMakeRange(pastpos, content.length-pastpos)];
        pastpos = [content indexOf:@"<" atRange:NSMakeRange(prepos, content.length - prepos)];
        [postItem  setValue: [[content substringWithRange:NSMakeRange(prepos+1, pastpos - prepos - 1)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"AuthorID"];
        
        [postItems addObject:postItem];
    }
}

-(NSArray*)getPostItems
{
    return postItems;
}
@end
