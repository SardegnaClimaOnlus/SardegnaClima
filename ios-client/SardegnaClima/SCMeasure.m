//
//  SCMeasure.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCMeasure.h"

@implementation SCMeasure
@synthesize temp;
@synthesize tempmax;
@synthesize tempmin;
@synthesize hum;
@synthesize dp;
@synthesize wchill;
@synthesize hindex;
@synthesize wspeed;
@synthesize dir;
@synthesize bar;
@synthesize rain;
@synthesize rr;
@synthesize rainmt;
@synthesize rainyr;
@synthesize measureTime;

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
      measureTime:(NSDate *) aMeasureTime{
    self = [super init];
    if(self){
        temp = aTemp;
        tempmax = aTempMax;
        tempmin = aTempmin;
        hum = aHum;
        dp = aDp;
        wchill = aWchill;
        hindex = aHindex;
        wspeed = aWspeed;
        dir = aDir;
        bar = aBar;
        rain = aRain;
        rr = aRr;
        rainmt = aRainmt;
        rainyr = aRainyr;
        measureTime = aMeasureTime ;
    }
    return self;
    
}
@end
