//
//  Trip.h
//  goeuro
//
//  Created by ray on 2016/11/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property (nonatomic,retain) NSString * providerLogo;
@property (nonatomic,retain) NSDate * departureTime;
@property (nonatomic,retain) NSDate * arrivalTime;
@property int numberOfStops;
@property float  priceInEuros;
@property int mode;
- (id)initWithJSONDict:(NSDictionary *)dict Model:(int)trip_model;
+(NSMutableArray*)getTrips:(int)trip_type;
+(void) saveTrips:(NSMutableArray*)tripsList tripType:(int)trip_type;
-(NSString*)getDireectTimeDeparture:(NSDate*)depar_time Arrival:(NSDate*)arrive_time;
-(NSString*)getTravelTimeDeparture:(NSDate*)depar_time Arrival:(NSDate*)arrive_time stop:(int)stopNumber;
- (NSString*)getPrice:(float)price;
@end
