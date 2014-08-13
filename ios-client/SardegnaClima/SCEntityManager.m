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



#pragma mark SCApiManager protocol
-(void)summaryDidReceived:(NSDictionary *)aSummary{
 // generate summary object here
}
-(void)stationsDidReceived:(NSArray *)stations{
    //NSArray * stationsArray = [stations objectForKey:@"stations"];
    NSMutableArray * generatedStations = [[NSMutableArray alloc]init] ;
    for (NSDictionary * item in stations) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * latitude = [f numberFromString:[item objectForKey:@"latitude"]];
        NSNumber * longitude = [f numberFromString:[item objectForKey:@"longitude"]];
        SCStation * station = [[SCStation alloc]initWithId:[item objectForKey:@"id"]
                                                  latitude:latitude
                                                 longitude:longitude
                                                      name:[item objectForKey:@"name"]];
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
