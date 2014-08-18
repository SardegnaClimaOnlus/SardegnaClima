//
//  SCMapManager.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCStation.h"
#import "SCMapView.h"

@interface SCMapManager : NSObject

@property(strong, nonatomic)SCMapView * mapView;

-(void)showStationInMap:(NSArray *)stations;
@end
