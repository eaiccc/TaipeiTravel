//
//  TTAtractions.h
//  TaipeiTravel
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 Link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAttractions : NSObject
- (void) initWithDic:(NSDictionary*) dictionary;
@property(nonatomic,strong) NSDictionary* dictionary;
@property(nonatomic,strong) NSString* attractionId;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* body;
@property(nonatomic,strong) NSArray* files;

@end
