//
//  APIManager.h
//  goeuro
//
//  Created by Ray on 2016/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_HOST  @"https://api.myjson.com/"
#define BUS_PATH  @"bins/37yzm"
#define TRAIN_PATH  @"bins/3zmcy"
#define FLIGHT_PATH  @"bins/w60i"

@interface APIManager : NSObject

+ (APIManager *)sharedInstance;
- (void)getLatestBuses:(void (^)(id object))success
                  failure:(void (^)(NSString *errorMsg, NSError *error))failure;
- (void)getLatesTrains:(void (^)(id object))success
                  failure:(void (^)(NSString *errorMsg, NSError *error))failure;
- (void)getLatesFlights:(void (^)(id object))success
                   failure:(void (^)(NSString *errorMsg, NSError *error))failure;
@end
