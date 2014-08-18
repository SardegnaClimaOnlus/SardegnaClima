//
//  SCMapManager.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCMapManager.h"
#import "SCStation.h"

@implementation SCMapManager
@synthesize mapView;

-(id)init{
    self = [super init];
    if(self){
        mapView = [[SCMapView  alloc] init];
    }
    return self;
}

-(void)showStationInMap:(NSArray *)stations{
    for (SCStation * station in stations) 
        [mapView addMarkerWithLatitude:station.latitude longitude:station.longitude temperature:[NSNumber numberWithFloat:13.0f]];
}





@end
