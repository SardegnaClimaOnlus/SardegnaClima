//
//  SCMarker.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 15/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "SCStation.h"
@interface SCMarker : GMSMarker

-(id)initWithStation:(SCStation *)aStation;
@property(strong, nonatomic)SCStation * station;
@end
