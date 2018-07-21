//
//  MockTravelViewModelDelegate.m
//  TaipeiTravelTests
//
//  Created by Mac on 2018/7/22.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "MockTravelViewModelDelegate.h"


@interface MockTravelViewModelDelegate () 
@end
@implementation
    MockTravelViewModelDelegate
- (instancetype) init{
    self = [super init];
    _isCallShowHud = NO;
    _isCallDataDidLoad = NO;
    _isCallGetDataFail = NO;
    return self;
}
- (void)dataDidLoad{
    self.isCallDataDidLoad = YES;
}
- (void)getDataFail:(NSError*)error{
    self.isCallGetDataFail = YES;
}
- (void)showHud:(BOOL)isShow{
    self.isCallShowHud = YES;
}
@end
