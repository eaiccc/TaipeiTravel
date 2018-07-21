//
//  TTDataManager.m
//  TaipeiTravel
//
//  Created by Mac on 2018/7/18.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "TTDataManager.h"
#import "AFHTTPSessionManager.h"
#import "TTConst.h"
@implementation TTDataManager
+ (id)sharedDataManager {
    static TTDataManager *sharedDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

- (void)getTravelData:(NSNumber *)limit
        withOffset:(NSNumber *)offset
            success:(void (^)(NSDictionary *dic))success
            failure:(void (^)(NSError *error))failure {
    NSString *p_url = URLPREFIX;
    NSDictionary *input = @{
                            @"scope" : @"resourceAquire",
                            @"rid" : URLTRAVELRID,
                            @"limit" : limit,
                            @"offset" : offset
                            };
    [self getQuery:input failure:failure success:success p_url:p_url];
}
#pragma mark- Networking

//Update the api with AFNetworking 2.0
- (void)getQuery:(NSDictionary *)input
          failure:(void (^)(NSError *))failure
          success:(void (^)(NSDictionary *))success
            p_url:(NSString *)urlString {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30.f;
    configuration.timeoutIntervalForResource = 30.f;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:input];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    

    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        NSDictionary *p_dic = responseObject;
        
        if (p_dic !=nil) {
            if (success) {
                success(p_dic);
            }
        }else if (failure) {
            NSError *error =
                        [NSError errorWithDomain:@"org.link.travel"
                                            code:200
                                      userInfo:responseObject];
            failure(error);
        }

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        LogMethodArgs(@"%@", [error localizedDescription]);
        if (failure) {
            failure(error);
        }
    }];
}
@end
