//
//  DemoManager.m
//  goeuro
//
//  Created by ray on 2016/11/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "DemoManager.h"
#import "APIManager.h"
#import "Trip.h"


@interface DemoManager()
@property (nonatomic, strong) APIManager *apiManager;
@end


@implementation DemoManager

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
    
    self.apiManager  = [APIManager sharedInstance];
    
}

-(void)getDatafromServer:(int)page withSucess:(void(^)(NSMutableArray*))success
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];

    if (page == 0) {
        [self.apiManager getLatesTrains:^(id object) {
            NSMutableArray *responseArray = (NSMutableArray*)object;
            for (NSDictionary *item in responseArray) {
                Trip *trip = [[[Trip alloc]init] initWithJSONDict:item Model:page];
                [resultArray addObject:trip];
            }
            [Trip saveTrips:resultArray tripType:page];
            success(resultArray);
        } failure:^(NSString *errorMsg, NSError *error) {
            
        }];
    }else if(page == 1){
        [self.apiManager getLatestBuses:^(id object) {
            NSMutableArray *responseArray = (NSMutableArray*)object;
            for (NSDictionary *item in responseArray) {
                Trip *trip = [[[Trip alloc]init] initWithJSONDict:item Model:page];
                [resultArray addObject:trip];
                
            }
            [Trip saveTrips:resultArray tripType:page];
            success(resultArray);
        } failure:^(NSString *errorMsg, NSError *error) {
            
        }];
    }else if (page ==2){
        [self.apiManager getLatesFlights:^(id object) {
            NSMutableArray *responseArray = (NSMutableArray*)object;
            for (NSDictionary *item in responseArray) {
                Trip *trip = [[[Trip alloc]init] initWithJSONDict:item Model:page];
                [resultArray addObject:trip];
                
            }
            [Trip saveTrips:resultArray tripType:page];
            success(resultArray);
        } failure:^(NSString *errorMsg, NSError *error) {
            
        }];
    }

}

#pragma mark - singleton implementation code

+ (DemoManager *)sharedInstance {
    
    static dispatch_once_t pred;
    static DemoManager *manager;
    
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
@end
