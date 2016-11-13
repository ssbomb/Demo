//
//  Route+CoreDataProperties.m
//  goeuro
//
//  Created by Ray on 2016/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "Route+CoreDataProperties.h"

@implementation Route (CoreDataProperties)

+ (NSFetchRequest<Route *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Route"];
}

@dynamic type;
@dynamic img_url;
@dynamic price;
@dynamic departure_time;
@dynamic arrival_time;
@dynamic number_of_stops;

@end
