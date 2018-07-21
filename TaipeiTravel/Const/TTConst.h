//
//  TTConst.h
//  
//
//  Created by Mac on 2018/7/18.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define LogMethod NSLog(@"%s-%d", __PRETTY_FUNCTION__, __LINE__);
#define LogMethodArgs(format, ...) NSLog(@"%s: %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
#define LogMethod \
{             \
}
#define LogMethodArgs(format, ...) \
{                              \
}
#endif
static NSString *const URLPREFIX = @"http://data.taipei/opendata/datalist/apiAccess";
static NSString *const URLSCOPE = @"scope=resourceAquire";
static NSString *const URLTRAVELRID =@"36847f3f-deff-4183-a5bb-800737591de5";

static NSString *AttractionPhotoClickNotification = @"AttractionPhotoClickNotification";
@interface TTConst : NSObject

@end
