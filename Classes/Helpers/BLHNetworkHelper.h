//
//  BLHNetworkHelper.h
//  yssy
//
//  Created by Rurui Ye on 1/27/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^HttpResponseBlock)(NSDictionary *result);

@interface BLHNetworkHelper : NSObject
-(void) postRequest: (NSString*) url andParams:(NSMutableDictionary*) params onCompletion:(HttpResponseBlock)completionBlock;
-(void) sendRequest: (NSString*) url andParams:(NSMutableDictionary*) params onCompletion:(HttpResponseBlock)completionBlock;
-(void) getContent: (NSString*) url onCompletion:(HttpResponseBlock)completionBlock;
-(void) getJsonContent: (NSString*) url onCompletion:(HttpResponseBlock)completionBlock;

+(NSString *)convertResponseToString: (id)responseObject;
+(AFHTTPRequestOperationManager*) manager;
@end
