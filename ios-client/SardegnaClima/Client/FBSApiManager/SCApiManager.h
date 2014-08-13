//
//  HttpManager.h
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 31/03/14.
//
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

#import <Foundation/Foundation.h>
#import "SCApiActions.h"


typedef enum {
    BadRequestHttpStatus = 400,
    InternalServerErrorHttpStatus = 500
}HttpStatus;

@protocol SCStationsRequiring
-(void)summaryDidReceived:(NSDictionary *)aSummary;
-(void)stationsDidReceived:(NSDictionary *)stations;
-(void)stationDetailDidReceived:(NSDictionary *)aDetails forKey:(NSString* )aKey;
-(void)lastStationMeasureDidReceived:(NSDictionary *)aDetails forKey:(NSString* )aKey;

@end

@interface SCApiManager : NSObject {
    NSMutableDictionary * requests;

}
@property(nonatomic,retain)NSNumber * requestCounter;
+ (SCApiManager *) getSharedInstance;
#pragma mark main protocol
#pragma mark FBSApiManagerDelegate protocol implementation
-(void)getStationsForDelegate:(id)aDelegate;
-(void)getSummaryForDelegate:(id)aDelegate;
-(void)getStationById:(NSString * )anId delegate:(id)aDelegate;
-(void)getLastStationMeasureByStationId:(NSString * )aStationId delegate:(id)aDelegate;



@end

