//
//  MockApiService.h
//  TaipeiTravelTests
//
//  Created by Mac on 2018/7/22.
//  Copyright © 2018年 Link. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTProtocol.h"
@interface MockApiService : NSObject<APIService>
@property(atomic,assign) BOOL isFailFetch;
@end
