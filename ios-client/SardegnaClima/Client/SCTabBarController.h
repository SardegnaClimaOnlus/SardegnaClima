//
//  SCTabBarController.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 10/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MapViewController.h"
#import "SardegnaClimaViewController.h"
#import "CreditsViewController.h"
@interface SCTabBarController : UITabBarController

@property(strong, nonatomic)SardegnaClimaViewController * sardegnaClimaViewController;
@property(strong, nonatomic)MapViewController * mapViewController;
@property(strong, nonatomic)CreditsViewController * creditsViewController;
@property(strong, nonatomic)NSArray * stations;
@end
