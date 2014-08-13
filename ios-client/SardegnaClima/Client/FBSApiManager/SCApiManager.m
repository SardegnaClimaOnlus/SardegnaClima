//
//  HttpManager.m
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


#import "SCURLConnection.h"
#import "SCApiManager.h"
#import "SCApiPendingRequest.h"

@implementation SCApiManager
@synthesize requestCounter;
static SCApiManager *sharedSingleton_      = nil;

-(id)init
{
    self = [super init];
    if(self){
        requests = [NSMutableDictionary new];
        requestCounter = [[NSNumber alloc] initWithInt:0];
    }
    
    
    return self;
}


#pragma mark FBSApiManagerDelegate protocol implementation
-(void)getStationsForDelegate:(id)aDelegate{
    static  NSString * _stationsUrl = @"http://";
    if(!aDelegate)return;
    [self sendRequestWithUrl:[NSURL URLWithString:_stationsUrl]  andAction:SCActionStations andTarget:aDelegate forKey:nil];
}

-(void)getSummaryForDelegate:(id)aDelegate{
    static  NSString * _summaryUrl = @"http://";
    if(!aDelegate)return;
    [self sendRequestWithUrl:[NSURL URLWithString:_summaryUrl]  andAction:SCActionSummary andTarget:aDelegate forKey:nil];
}

-(void)getStationDetailById:(NSString * )anId delegate:(id)aDelegate{
    static NSString * _stationDetailUrl = @"http://";
    if(!anId || !aDelegate) return;
    [self sendRequestWithUrl:[NSURL URLWithString:_stationDetailUrl]  andAction:SCActionStationDetail andTarget:aDelegate forKey:anId];
}


#pragma mark utilities
-(NSDictionary *)dataToJson:(NSData *)data
{
    NSError* jsonError;
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:&jsonError];
    NSDictionary * error = [json objectForKey:@"error"];
    if(error){
        NSArray * errors = [error objectForKey:@"errors"];
        NSString * reason = nil;
        if(errors && [errors count] > 0)
            reason = [[self firstErrorWithErrors:errors] objectForKey:@"reason"];
        switch ([[error objectForKey:@"code"] intValue]) {
            case BadRequestHttpStatus:
                break;
            case InternalServerErrorHttpStatus:
                
                break;
            default:
                break;
        }
    }
    return json;
}

-(NSDictionary *)firstErrorWithErrors:(NSArray *)errors
{
    return [errors objectAtIndex:0];
}

-(void)increaseRequestCounter
{
    int value = [requestCounter intValue];
    self.requestCounter = [NSNumber numberWithInt:value + 1];
}

#pragma mark requests managers
-(void)sendRequestWithUrl:(NSURL* )anUrl andAction:(SCApiAction)anAction andTarget:(id<SCStationsRequiring>)aTarget forKey:(NSString *)aKey
{
    if(anUrl && anAction && aTarget && requests){
        SCURLConnection * connection = [[SCURLConnection alloc] initWithUrl:anUrl delegate:self requestId:self.requestCounter];
        SCApiPendingRequest * apiRequest = [[SCApiPendingRequest alloc] initWithURLConnection:connection action:anAction key:aKey delegate:self target:aTarget];
        [requests setObject:apiRequest forKey:self.requestCounter];
        [self increaseRequestCounter];
        [connection start];
    }
}

#pragma mark static method
+ (SCApiManager *) getSharedInstance {
    if (sharedSingleton_ == nil) 
        sharedSingleton_ = [[SCApiManager alloc] init];
    return sharedSingleton_;
}

#pragma mark switch types of requestes
- (void) responseDidReceived:(NSData *)response forRequest:(NSNumber *) aRequestId
{
    SCApiPendingRequest * apiRequest = [requests objectForKey:aRequestId] ;
  
    if(apiRequest.target && response)
        switch(apiRequest.action){
            case SCActionSummary:
                [apiRequest.target summaryDidReceived:[self dataToJson:response]];
                break;
            case SCActionStations:
                [apiRequest.target stationsDidReceived:[self dataToJson:response]];
                break;
            case SCActionStationDetail:
                [apiRequest.target stationDetailDidReceived:[self dataToJson:response]  forKey:apiRequest.key];
                break;
            default:
            break;
        }
   [requests removeObjectForKey:aRequestId];
}



@end



