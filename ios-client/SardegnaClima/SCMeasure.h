//
//  SCMeasure.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCMeasure : NSObject
@property(strong, nonatomic)NSNumber* temp;
@property(strong, nonatomic)NSNumber* tempmax;
@property(strong, nonatomic)NSNumber* tempmin;
@property(strong, nonatomic)NSNumber* hum;
@property(strong, nonatomic)NSNumber* dp;
@property(strong, nonatomic)NSNumber* wchill;
@property(strong, nonatomic)NSNumber* hindex;
@property(strong, nonatomic)NSNumber* wspeed;
@property(strong, nonatomic)NSString* dir;
@property(strong, nonatomic)NSNumber* bar;
@property(strong, nonatomic)NSNumber* rain;
@property(strong, nonatomic)NSNumber* rr;
@property(strong, nonatomic)NSNumber* rainmt;
@property(strong, nonatomic)NSNumber* rainyr;
@property(strong, nonatomic)NSDate* measureTime;
-(id)initWithTemp:(NSNumber *) aTemp
          tempmax:(NSNumber *) aTempMax
          tempmin:(NSNumber *) aTempmin
              hum:(NSNumber *) aHum
               dp:(NSNumber *) aDp
           wchill:(NSNumber *) aWchill
           hindex:(NSNumber *) aHindex
           wspeed:(NSNumber *) aWspeed
              dir:(NSString *) aDir
              bar:(NSNumber *) aBar
             rain:(NSNumber *) aRain
               rr:(NSNumber *) aRr
           rainmt:(NSNumber *) aRainmt
           rainyr:(NSNumber *) aRainyr
      measureTime:(NSDate *) aMeasureTime;
@end


