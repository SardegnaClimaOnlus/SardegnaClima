//
//  SCStationViewController.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 16/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStationView.h"
#import "SCStation.h"

@interface SCStationViewController : UIViewController{
    SCStationView * stationView;
    SCStation * station;
}

-(id)initWithStation:(SCStation * )aStation;


@end
