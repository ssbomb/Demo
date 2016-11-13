//
//  Trip.m
//  goeuro
//
//  Created by ray on 2016/11/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "Trip.h"
#import "AutoCoding.h"

@implementation Trip
+(NSString*)fileName:(int)trip_type
{
    NSString *typePath;
    switch (trip_type) {
        case 0:
            typePath = @"_0";
            break;
        case 1:
            typePath = @"_1";
            break;
        case 2:
            typePath = @"_2";
            break;
        default:
            break;
    }
    NSString *user = [@"goeuro" stringByAppendingString:typePath];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.trip",user]];
}

+(NSMutableArray*)getTrips:(int)trip_type
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[Trip fileName:trip_type]];
}

+(void) saveTrips:(NSMutableArray*)tripsList tripType:(int)trip_type
{
    
    [NSKeyedArchiver archiveRootObject:tripsList toFile:[Trip fileName:trip_type]];
}

- (id)initWithJSONDict:(NSDictionary *)dict Model:(int)trip_model
{
    self = [super init];
    if (self) {
        NSString *urlSTR = [(NSString*)[dict objectForKey:@"provider_logo"] stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
        _providerLogo = urlSTR;
        _departureTime = [self dateFromHMFormat:[dict objectForKey:@"departure_time"]];
        _arrivalTime = [self dateFromHMFormat:[dict objectForKey:@"arrival_time"]];
        _numberOfStops = [[dict objectForKey:@"number_of_stops"] intValue];
        _priceInEuros = [[dict objectForKey:@"price_in_euros"] floatValue];
        _mode = trip_model;
    }
    return self;
}

-(NSString*)getTravelTimeDeparture:(NSDate*)depar_time Arrival:(NSDate*)arrive_time stop:(int)stopNumber
{
    NSString *departureStr = [self formattedTimeFromDate:depar_time];
    NSString *arrivalStr = [self formattedTimeFromDate:arrive_time];
    NSString *travelTime = [NSString stringWithFormat:@"%@-%@", departureStr, arrivalStr];
    NSString *changes = self.numberOfStops > 0 ? [NSString stringWithFormat:@" (+%ld)", (long)self.numberOfStops] : @"";
    return [NSString stringWithFormat:@"%@%@", travelTime, changes];

}

-(NSString*)getDireectTimeDeparture:(NSDate*)depar_time Arrival:(NSDate*)arrive_time
{
    NSTimeInterval direct =  [arrive_time timeIntervalSinceDate:depar_time];
    return [NSString stringWithFormat:@"Direct %@h", [self stringHHMMFromTimeInterval:direct]];
}

- (NSString*)getPrice:(float)price
{
    return [NSString stringWithFormat:@"\u20ac %2.2f", price];
}

-(NSString *)formattedTimeFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute)
                                               fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    return [NSString stringWithFormat:@"%02ld:%02ld", hour, minute];
}

-(NSDate *)dateFromHMFormat:(NSString *)format
{
    NSArray *components = [format componentsSeparatedByString:@":"];
    if (components.count >= 2) {
        NSUInteger hours   = [components[0] integerValue] * 3600;
        NSUInteger minutes = [components[1] integerValue] * 60;
        NSTimeInterval ti = hours + minutes;
        NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
        return [startOfToday dateByAddingTimeInterval:ti];
    }
    return nil;
}

-(NSString *)stringHHMMFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)hours, (long)minutes];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [self init]))
    {
        for (NSString *key in [self codableProperties])
        {
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    for (NSString *key in [self codableProperties])
    {
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

@end
