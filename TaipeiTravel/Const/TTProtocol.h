//
//  TTProtocol.h
//  TaipeiTravel
//
//  Created by Mac on 2018/7/21.
//  Copyright © 2018年 Link. All rights reserved.
//

#ifndef TTProtocol_h
#define TTProtocol_h


#endif /* TTProtocol_h */
@protocol TTTravelViewModelDelegate <NSObject>
- (void)dataDidLoad;
- (void)getDataFail:(NSError*)error;
- (void)showHud:(BOOL)isShow;
@end

@protocol APIService<NSObject>
+ (id)sharedDataManager;
- (void)getTravelData:(NSNumber *)limit
withOffset:(NSNumber *)offset
success:(void (^)(NSDictionary *dic))success
failure:(void (^)(NSError *error))failure;
@end
