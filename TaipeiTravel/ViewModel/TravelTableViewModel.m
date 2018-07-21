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
    int travelTotal;
    int travelOffset;
    int travelLimit;
    BOOL isLoading;
    id<TTTravelViewModelDelegate> viewModeldelegate;
    
}
@end
@implementation TravelTableViewModel
- (instancetype)initWithDelegate:(id<TTTravelViewModelDelegate>) delegate{
    self = [super init];
    if (!self) return nil;
    isLoading = NO;
    viewModeldelegate = delegate;
    _attractions = NSMutableArray.new;
    _apiService = [TTDataManager sharedDataManager];
    return self;
}
-(void) getTravelData {
    [self getTravelData:10 withOffset:0];
}
- (void)getTravelData:(int) limit withOffset:(int) offset {
    if (isLoading){
        return;
    }
    [viewModeldelegate showHud:YES];
    isLoading = YES;
    [self.apiService getTravelData:@(limit) withOffset:@(offset) success:^(NSDictionary *dic) {
        [self->viewModeldelegate showHud:NO];
        self->isLoading = NO;
        if (!dic)
            return;
        [self parseData:dic[@"result"]];

        
    }failure:^(NSError *error) {
        self->isLoading = NO;
        [self->viewModeldelegate showHud:NO];
        [self->viewModeldelegate getDataFail:error];
    }];
}
- (void) parseData:(NSDictionary *)input {
    NSNumber *offset = input[@"offset"];
    NSNumber *limit = input[@"limit"];
    NSNumber *count = input[@"count"];
    NSArray *results = input[@"results"];
    travelTotal = count.intValue;
    travelLimit = limit.intValue;
    travelOffset = offset.intValue ;
    for (NSDictionary *result in results) {
        TTAttractions *attraction = TTAttractions.new;
        [attraction initWithDic:result];
        [_attractions addObject:attraction];
        [viewModeldelegate dataDidLoad];
        //NSLog(@"attraction: %@", attraction.title);
    }
    
}
- (void) loadMore{
    int offset = travelOffset + travelLimit;
    //NSLog(@"load more offset %d", offset);
    if (offset < travelTotal) {
        [self getTravelData:10 withOffset: offset];
    }
}
@end
