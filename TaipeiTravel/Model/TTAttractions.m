//
//  TTAtractions.m
//  TaipeiTravel
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "TTAttractions.h"

@implementation TTAttractions
- (void) initWithDic:(NSDictionary*) dictionary{
    self.dictionary = dictionary;
    self.attractionId = dictionary[@"_id"];
    self.title = dictionary[@"stitle"];
    self.body = dictionary[@"xbody"];
    [self spiltFiles:dictionary[@"file"]];
}
- (void) spiltFiles:(NSString*) inputfiles{
    NSArray *items = [inputfiles componentsSeparatedByString:@"http"];
    NSMutableArray *fileItems = NSMutableArray.new;
    for(NSString *item in items) {
        if (item.length > 0 && [self isPicture:item]) {
            NSString *filePath = [NSString stringWithFormat:@"http%@", item];
            [fileItems addObject:filePath];
        }
    }
    if (fileItems.count> 0) {
        self.files =  [NSArray arrayWithArray:fileItems];
    }
}

- (BOOL) isPicture:(NSString*) input {
    NSURL *url = [NSURL URLWithString:input];
    NSString *path = [url path];
    NSString *extension = [path pathExtension];
    if ([[extension uppercaseString] isEqualToString:@"JPG"]) {
        return true;
    }
    return false;
}

@end
