//
//  BLHTopTenList.m
//  yssy
//
//  Created by Rurui Ye on 1/30/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHTopTenParser.h"
#import "BLHStringExtension.h"
#import "TFHpple.h"
#import "BLHTopTenItem.h"
@interface BLHTopTenParser()
@end

@implementation BLHTopTenParser

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
    NSString *utf8HtmlStr = [content stringByReplacingOccurrencesOfString:
                             @"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">"
                            withString:
                             @"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];

    NSData* data = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple* xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray* topTenElements = [xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[2]/tr[1]/td[2]/table/tr[2]/td/table/tr"];
    [postItems addObject:[self parserSection:topTenElements]];
    
    NSArray* section0Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[7]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section0Elements]];
    
    NSArray* section1Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[10]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section1Elements]];
    
    
    NSArray* section2Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[13]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section2Elements]];
    
    
    
    NSArray* section3Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[16]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section3Elements]];
    
    
    
    NSArray* section4Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[19]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section4Elements]];
    
    
    
    NSArray* section5Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[22]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section5Elements]];
    
    
    
    NSArray* section6Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[25]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section6Elements]];
    
    
    
    NSArray* section7Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[28]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section7Elements]];
    
    
    NSArray* section8Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[31]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section8Elements]];
    
    NSArray* section9Elements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[34]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:section9Elements]];
    
    NSArray* sectionAElements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[37]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:sectionAElements]];
    
    
    NSArray* sectionBElements =[xpathParser searchWithXPathQuery:@"/html/body/form/table[3]/tr/td[1]/table[3]/tr[1]/td[2]/table/tr[40]/td/table/tr/td/table/tr"];
    [postItems addObject:[self parserSection:sectionBElements]];
    
    /*int pastpos = 1;
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
    }*/
}

-(NSArray*)parserSection:(NSArray*) topTenElements
{
    NSMutableArray* topten = [[NSMutableArray alloc]init];
    for (TFHppleElement* element in topTenElements) {
        BLHTopTenItem* item = [[BLHTopTenItem alloc]init];
        NSArray* children = [element childrenWithTagName:@"td"];
        TFHppleElement* boardElement = [children objectAtIndex:0];
        TFHppleElement* boardtag = [[boardElement childrenWithTagName:@"a"] objectAtIndex:0];
        item.board = [boardtag.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        TFHppleElement* titleElement = [children objectAtIndex:1];
        TFHppleElement* titleTag = [[titleElement childrenWithTagName:@"a"] objectAtIndex:0];
        item.title = [titleTag.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        item.url = [[[titleTag attributes] valueForKey:@"href"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        TFHppleElement* authorElement = [children objectAtIndex:2];
        item.author = [authorElement.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [topten addObject:item];
    }
    return topten;
}

-(NSArray*)getPostItems
{
    return postItems;
}
@end
