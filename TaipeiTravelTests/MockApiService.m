//
//  MockApiService.m
//  TaipeiTravelTests
//
//  Created by Mac on 2018/7/22.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "MockApiService.h"

@implementation MockApiService
+ (id)sharedDataManager {
    static MockApiService *shareService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareService = [[self alloc] init];
    });
    shareService.isFailFetch = NO;
    return shareService;
}

- (void)getTravelData:(NSNumber *)limit
           withOffset:(NSNumber *)offset
              success:(void (^)(NSDictionary *dic))success
              failure:(void (^)(NSError *error))failure {
    
    if (self.isFailFetch) {
        NSDictionary *responseObject = @{
                                @"NSLocalizedDescription" : @"Test Fail fetch"};
        NSError *error =
        [NSError errorWithDomain:@"org.link.travel"
                            code:200
                        userInfo:responseObject];
        failure(error);
    }else {
        NSArray *attractions =@[@{
                                    @"_id":@"1",
                                    @"stitle":@"title1",
                                    @"xbody":@"body1",
                                    @"files":@"http://test.11.dd/test.jpg"
                                    }];
        NSDictionary *pageDic = @{
                                  @"offset": @0,
                                  @"limit":@10,
                                  @"count":@230,
                                  @"results":attractions
                                  };
        NSDictionary *responseObject = @{@"result" : pageDic};
        success(responseObject);
    }
    
}
@end
