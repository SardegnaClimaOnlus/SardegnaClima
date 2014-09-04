//
//  SCMapView.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCMapView.h"
#import "SCStation.h"
#import "SCMarkerLabel.h"
#import "SCMarker.h"

@implementation SCMapView{
    
}
const struct CentreSardiniaStruct CentreSardinia = {
    .lat = 40.120878f,
    .lon = 9.012910f
};

const float DEFAULT_ZOOM = 8.5f;

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:CentreSardinia.lat
                                                                longitude:CentreSardinia.lon
                                                                     zoom:DEFAULT_ZOOM];
        [self setCamera:camera];
        [self setMapType:kGMSTypeTerrain];
        [self setMinZoom:DEFAULT_ZOOM maxZoom:self.maxZoom];
    }
    return self;
}

-(void)addMarkerWithStation:(SCStation *)aStation{
    if(aStation.lastMeasure.temp){
        SCMarker * marker  = [[SCMarker alloc] initWithStation:(SCStation *)aStation];
        marker.map = self;
    }
}




-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
}


-(void)showStationInMap:(NSArray *)stations{
    for (SCStation * station in stations)
        [self addMarkerWithStation:station];
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    return nil;
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker {
    NSLog(@"%@",marker);
    return nil;
}

@end
