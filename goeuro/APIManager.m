//
//  APIManager.m
//  goeuro
//
//  Created by Lezyne on 2016/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "AFDownloadRequestOperation.h"

@interface APIManager()
@property (nonatomic, strong) AFHTTPClient *storeClient;
@property (nonatomic, assign) UIBackgroundTaskIdentifier *backgroundTaskIdentifier;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) AFDownloadRequestOperation *currentDownloadOp;
@property (nonatomic, assign) BOOL shouldPause;
@end

@implementation APIManager
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.storeClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://bo.carrefour-mobile.com.tw/"] ];
    [self.storeClient setParameterEncoding:AFJSONParameterEncoding];
    
//    [self.storeClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    self.operationQueue = [[NSOperationQueue alloc] init];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserverForName:UIApplicationDidEnterBackgroundNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        
                        if(self.shouldPause)
                            [self.currentDownloadOp pause];
                        
                    }];
    
    [center addObserverForName:UIApplicationWillEnterForegroundNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        
                        if(self.shouldPause)
                        {
                            [self.currentDownloadOp resume];
                            self.shouldPause = NO;
                        }
                        
                    }];
    
    [self.storeClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if(status == AFNetworkReachabilityStatusNotReachable)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_DISCONNECTED_NOTIF object:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_CONNECTED_NOTIF object:nil];
        }
        
    }];
    
}

#pragma mark - singleton implementation code

//static APIManager *singletonManager = nil;
+ (APIManager *)sharedInstance {
    
    static dispatch_once_t pred;
    static APIManager *manager;
    
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

@end
