//
//  TravelTableViewModel.h
//  TaipeiTravel
//
//  Created by Mac on 2018/7/21.
//  Copyright © 2018年 Link. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTProtocol.h"
@interface TravelTableViewModel : NSObject
- (instancetype)initWithDelegate:(id<TTTravelViewModelDelegate>) delegate;
-(void) getTravelData;
- (void)getTravelData:(int) limit withOffset:(int) offset;
- (void) loadMore;
@property (nonatomic, readonly) NSMutableArray *attractions;
@property (nonatomic, weak) id<APIService> apiService;
@property(nonatomic, weak) id<TTTravelViewModelDelegate> viewModeldelegate;
@property(atomic, assign) int travelTotal;
@property(atomic, assign) int travelOffset;
@property(atomic, assign) int travelLimit;
@property(atomic, assign) BOOL isLoading;
@end
