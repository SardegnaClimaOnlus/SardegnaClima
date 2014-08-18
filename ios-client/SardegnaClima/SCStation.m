//
//  SCStation.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCStation.h"


@implementation SCStation
@synthesize stationId;
@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize lastMeasure;

-(id)initWithId:(NSNumber *)anId latitude:(NSNumber *)aLatitude longitude:(NSNumber *)aLongitude name:(NSString *)aName measure:(SCMeasure *)aMeasure{
    self = [super init];
    if(self){
        stationId = anId;
        latitude = aLatitude;
        longitude = aLongitude;
        name = aName;
        lastMeasure = aMeasure;
    }
    return self;
}

@end
