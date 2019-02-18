//
//  TravelTableViewModel.m
//  TaipeiTravel
//
//  Created by Mac on 2018/7/21.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "TravelTableViewModel.h"
#import "TTDataManager.h"
#import "TTAttractions.h"
@interface TravelTableViewModel () {

    
}
@end

@implementation TravelTableViewModel
- (instancetype)initWithDelegate:(id<TTTravelViewModelDelegate>) delegate{
    self = [super init];
    if (!self) return nil;
    _isLoading = NO;
    _viewModeldelegate = delegate;
    _attractions = NSMutableArray.new;
    _apiService = [TTDataManager sharedDataManager];
    return self;
}
-(void) getTravelData {
    [self getTravelData:10 withOffset:0];
}
- (void)getTravelData:(int) limit withOffset:(int) offset {
    if (self.isLoading){
        return;
    }
    [self.viewModeldelegate showHud:YES];
    self.isLoading = YES;
    __weak typeof(self) weakSelf = self;
    [self.apiService getTravelData:@(limit) withOffset:@(offset) success:^(NSDictionary *dic) {
        [weakSelf.viewModeldelegate showHud:NO];
        weakSelf.isLoading = NO;
        if (!dic)
            return;
        [self parseData:dic[@"result"]];

        
    }failure:^(NSError *error) {
        weakSelf.isLoading = NO;
        [weakSelf.viewModeldelegate showHud:NO];
        [weakSelf.viewModeldelegate getDataFail:error];
    }];
}
- (void) parseData:(NSDictionary *)input {
    NSNumber *offset = input[@"offset"];
    NSNumber *limit = input[@"limit"];
    NSNumber *count = input[@"count"];
    NSArray *results = input[@"results"];
    self.travelTotal = count.intValue;
    self.travelLimit = limit.intValue;
    self.travelOffset = offset.intValue ;
    for (NSDictionary *result in results) {
        TTAttractions *attraction = TTAttractions.new;
        [attraction initWithDic:result];
        [_attractions addObject:attraction];
        [self.viewModeldelegate dataDidLoad];
    }
    
}
- (void) loadMore{
    int offset = self.travelOffset + self.travelLimit;
    //NSLog(@"load more offset %d", offset);
    if (offset < self.travelTotal) {
        [self getTravelData:10 withOffset: offset];
    }
}
@end
