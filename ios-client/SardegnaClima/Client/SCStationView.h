//
//  SCStationView.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 19/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStation.h"

@interface SCStationView : UIView
{
    UILabel * title;
    UIButton * button;
    SCStation * station;
    BOOL showBorders;
    NSDictionary * windDirections;
}

-(id)initWithStation:(SCStation *)aStation;

@end
