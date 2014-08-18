//
//  FBSNodeManager.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 14/04/14.

/*****************************************************************************
 The MIT License (MIT)
 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 *****************************************************************************/

#import "SCEntityManager.h"
#import "SCApiManager.h"

@implementation SCEntityManager
@synthesize delegate;


-(id)initWithDelegate:(id)aDelegate
{
    self = [super init];
    if(self){
        delegate = aDelegate ;
        pendingLastStationMeasureRequests = [[NSMutableDictionary alloc]init];
    }
    return self;
}
#pragma mark main protocol
-(void)stations{
    [[SCApiManager getSharedInstance] getStationsForDelegate:self];
}

-(void)summary{
    [[SCApiManager getSharedInstance] getSummaryForDelegate:self];
}

-(void)stationDetailById:(NSString *)anId{
    [[SCApiManager getSharedInstance] getStationById:anId delegate:self];
}

-(void)lastStationMeasureByStationId:(NSString *) aStationId{
    [[SCApiManager getSharedInstance] getLastStationMeasureByStationId:aStationId delegate:self];
}

-(NSNumber *)numberFromString:(NSString *)string{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    return (string!= (id)[NSNull null])?([formatter numberFromString:string]):nil;
}

-(NSDate *)dateFromString:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh-mm-ss"];
    return (string!= (id)[NSNull null])?([dateFormatter dateFromString:string]):nil;
}

#pragma mark SCApiManager protocol
-(void)summaryDidReceived:(NSArray*)aSummary{
 // generate summary object here
    NSMutableArray * generatedStations = [[NSMutableArray alloc]init] ;


    for (NSDictionary * item in aSummary) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * latitude = [f numberFromString:[item objectForKey:@"latitude"]];
        NSNumber * longitude = [f numberFromString:[item objectForKey:@"longitude"]];
        SCMeasure * measure = [[SCMeasure alloc]initWithTemp:[self numberFromString:[item objectForKey:@"temp"]]
                                                     tempmax:[self numberFromString:[item objectForKey:@"tempmax"]]
                                                     tempmin:[self numberFromString:[item objectForKey:@"tempmin"]]
                                                         hum:[self numberFromString:[item objectForKey:@"hum"]]
                                                          dp:[self numberFromString:[item objectForKey:@"db"]]
                                                      wchill:[self numberFromString:[item objectForKey:@"wchill"]]
                                                      hindex:[self numberFromString:[item objectForKey:@"hindex"]]
                                                      wspeed:[self numberFromString:[item objectForKey:@"wspeed"]]
                                                         dir:[item objectForKey:@"dir"]
                                                         bar:[self numberFromString:[item objectForKey:@"bar"]]
                                                        rain:[self numberFromString:[item objectForKey:@"rain"]]
                                                          rr:[self numberFromString:[item objectForKey:@"rr"]]
                                                      rainmt:[self numberFromString:[item objectForKey:@"rainmt"]]
                                                      rainyr:[self numberFromString:[item objectForKey:@"rainyr"]]
                                                 measureTime:[self dateFromString:[item objectForKey:@"measure_time"]]];
        
        SCStation * station = [[SCStation alloc]initWithId:[item objectForKey:@"station_id"]
                                                  latitude:latitude
                                                 longitude:longitude
                                                      name:[item objectForKey:@"name"]
                                                        measure:measure];
        [generatedStations addObject:station];
    }
    [delegate summaryDidReceived:generatedStations];
}
-(void)stationsDidReceived:(NSArray *)stations{
    NSMutableArray * generatedStations = [[NSMutableArray alloc]init] ;
    for (NSDictionary * item in stations) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * latitude = [f numberFromString:[item objectForKey:@"latitude"]];
        NSNumber * longitude = [f numberFromString:[item objectForKey:@"longitude"]];
        SCMeasure * measure = [[SCMeasure alloc]initWithTemp:[item objectForKey:@"temp"]tempmax:[item objectForKey:@"tempmax"] tempmin:[item objectForKey:@"tempmin"] hum:[item objectForKey:@"hum"] dp:[item objectForKey:@"db"] wchill:[item objectForKey:@"wchill"] hindex:[item objectForKey:@"hindex"] wspeed:[item objectForKey:@"wspeed"] dir:[item objectForKey:@"dir"] bar:[item objectForKey:@"bar"] rain:[item objectForKey:@"rain"] rr:[item objectForKey:@"rr"] rainmt:[item objectForKey:@"rainmt"] rainyr:[item objectForKey:@"rainyr"] measureTime:[item objectForKey:@"measure_time"]];
        SCStation * station = [[SCStation alloc]initWithId:[item objectForKey:@"id"]
                                                  latitude:latitude
                                                 longitude:longitude
                                                      name:[item objectForKey:@"name"]
                                                   measure:measure];
        [generatedStations addObject:station];
    }
    [delegate stationsDidReceived:generatedStations];

    NSLog(@"%@",stations);
// generate stations collection here
}
-(void)stationDetailDidReceived:(NSDictionary *)aDetails forKey:(NSString* )aKey{
// generate station detail here
}
-(void)lastStationMeasureDidReceived:(NSDictionary *)aDetails forKey:(NSString* )aKey{
// generate station measure here
}

#pragma mark private methods


@end
