//
//  SCStation.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCMeasure.h"

@interface SCStation : NSObject

@property(strong, nonatomic)NSNumber * stationId;
@property(strong, nonatomic)NSNumber * latitude;
@property(strong, nonatomic)NSNumber * longitude;
@property(strong, nonatomic)NSString * name;
@property(strong, nonatomic)SCMeasure * lastMeasure;

-(id)initWithId:(NSNumber *)anId latitude:(NSNumber *)aLatitude longitude:(NSNumber *)aLongitude name:(NSString *)aName;
@end
