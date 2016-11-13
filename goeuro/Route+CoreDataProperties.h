//
//  Route+CoreDataProperties.h
//  goeuro
//
//  Created by Lezyne on 2016/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "Route+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Route (CoreDataProperties)

+ (NSFetchRequest<Route *> *)fetchRequest;

@property (nonatomic) int16_t type;
@property (nullable, nonatomic, copy) NSString *img_url;
@property (nullable, nonatomic, copy) NSDecimalNumber *price;
@property (nullable, nonatomic, copy) NSString *departure_time;
@property (nullable, nonatomic, copy) NSString *arrival_time;
@property (nonatomic) int16_t number_of_stops;

@end

NS_ASSUME_NONNULL_END
