//
//  SCMapView.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "SCStation.h"

@interface SCMapView : GMSMapView
struct CentreSardiniaStruct {
    double const lat;
    double const lon;
};
extern const float DEFAULT_ZOOM;
extern const struct CentreSardiniaStruct CentreSardinia;


-(void)addMarkerWithStation:(SCStation *)aStation;
-(void)showStationInMap:(NSArray *)stations;

@end
