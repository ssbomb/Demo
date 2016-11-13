//
//  APIManager.m
//  goeuro
//
//  Created by Ray on 2016/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "Constant.h"

@interface APIManager()
@property (nonatomic, assign) UIBackgroundTaskIdentifier *backgroundTaskIdentifier;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
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
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserverForName:UIApplicationDidEnterBackgroundNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        
                        
                        
                    }];
    
    [center addObserverForName:UIApplicationWillEnterForegroundNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        
                        
                    }];
}

-(AFHTTPRequestOperation *)callBaseApiwithBaseHost:(NSString*)basehost
                                             apiName:(NSString*)apiname
                                       authorization:(NSString*)auth
                                          parameters:(NSString*)parameters
                                             timeout:(NSTimeInterval)timeout
                                             success:(void (^)(id object))successCompletion
                                                fail:(void (^)(BOOL invalidPassword, NSString *message))failCompletion
{
    NSString *url = [basehost stringByAppendingString:apiname];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSString *body;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:auth forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:timeout];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             successCompletion([responseObject copy]);
         }];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             failCompletion(false,nil);
         }];
     }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    return op;
}


#pragma mark - Bus api

- (void)getLatestBuses:(void (^)(id object))success
                   failure:(void (^)(NSString *errorMsg, NSError *error))failure
{
    [self callBaseApiwithBaseHost:API_HOST
                          apiName:BUS_PATH
                    authorization:nil
                       parameters:nil
                          timeout:150
                          success:^(id object) {
                              success(object);
                            }
                             fail:^(BOOL invalidPassword, NSString *message) {
                                
                            }];
    
}

#pragma mark - Train api

- (void)getLatesTrains:(void (^)(id object))success
                failure:(void (^)(NSString *errorMsg, NSError *error))failure
{
    
    [self callBaseApiwithBaseHost:API_HOST
                          apiName:TRAIN_PATH
                    authorization:nil
                       parameters:nil
                          timeout:150
                          success:^(id object) {
                              success(object);
                          }
                             fail:^(BOOL invalidPassword, NSString *message) {
                                 
                             }];
}

#pragma mark - Flight api

- (void)getLatesFlights:(void (^)(id object))success
                  failure:(void (^)(NSString *errorMsg, NSError *error))failure
{
   
    [self callBaseApiwithBaseHost:API_HOST
                          apiName:FLIGHT_PATH
                    authorization:nil
                       parameters:nil
                          timeout:150
                          success:^(id object) {
                              success(object);
                            }
                             fail:^(BOOL invalidPassword, NSString *message) {
                                 
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
