//
//  MockTravelViewModelDelegate.h
//  TaipeiTravelTests
//
//  Created by Mac on 2018/7/22.
//  Copyright © 2018年 Link. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTProtocol.h"
@interface MockTravelViewModelDelegate : NSObject<TTTravelViewModelDelegate>
@property (atomic, assign) BOOL isCallDataDidLoad;
@property (atomic, assign) BOOL isCallGetDataFail;
@property (atomic, assign) BOOL isCallShowHud;
@end
