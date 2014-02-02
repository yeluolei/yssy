//
//  BLHNetworkHelper.m
//  yssy
//
//  Created by Rurui Ye on 1/27/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHNetworkHelper.h"

@interface BLHNetworkHelper()

@end

@implementation BLHNetworkHelper

-(void)sendRequest:(NSString *)url andParams:(NSMutableDictionary *)params onCompletion:(HttpResponseBlock)completionBlock
{
    [[BLHNetworkHelper manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] == 200){
            NSLog(@"%@", [BLHNetworkHelper convertResponseToString: responseObject]);
            completionBlock([NSDictionary dictionaryWithObject:responseObject forKey:@"data"]);
        }
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, id responseObject){NSLog(@"Error: sendRequest failed");}];
}

-(void)postRequest:(NSString *)url andParams:(NSMutableDictionary *)params onCompletion:(HttpResponseBlock)completionBlock
{
    AFHTTPRequestOperationManager* manager = [BLHNetworkHelper manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.responseSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200){
            //NSLog(@"%@", [BLHNetworkHelper convertResponseToString: responseObject]);
            completionBlock([NSDictionary dictionaryWithObject:responseObject forKey:@"data"]);
        }
        //NSLog(@"Login: %@",  [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding]);
        //return true;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey: @"error"]);
    }];
}

-(void)getContent:(NSString *)url onCompletion:(HttpResponseBlock)completionBlock
{
    AFHTTPRequestOperationManager* manager = [BLHNetworkHelper manager];
    [manager.requestSerializer setValue:@"AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5" forHTTPHeaderField:@"User-Agent"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200){
            //NSLog(@"%@", [BLHNetworkHelper convertResponseToString: responseObject]);
            completionBlock([NSDictionary dictionaryWithObject:responseObject forKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey: @"error"]);
    }];
}

-(void)getJsonContent:(NSString *)url onCompletion:(HttpResponseBlock)completionBlock
{
    AFHTTPRequestOperationManager* manager = [BLHNetworkHelper manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200){
            //NSLog(@"%@", [BLHNetworkHelper convertResponseToString: responseObject]);
            completionBlock([NSDictionary dictionaryWithObject:responseObject forKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey: @"error"]);
    }];
}

+(NSString *)convertResponseToString: (id)responseObject
{
    return [[NSString alloc] initWithData:(NSData*)responseObject
                                 encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}

+(AFHTTPRequestOperationManager*) manager
{
    static AFHTTPRequestOperationManager* _manager = nil;
    
    if (_manager == nil)
    {
        _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://bbs.sjtu.edu.cn/"]];
    }
    return _manager;
}
@end
