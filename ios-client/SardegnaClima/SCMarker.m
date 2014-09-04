//
//  SCMarker.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 15/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCMarker.h"
#import "SCMarkerLabel.h"

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation SCMarker
@synthesize station;


-(id)initWithStation:(SCStation *)aStation{
    self = [super init];
    if(self){
        station = aStation;
        self.position = CLLocationCoordinate2DMake([station.latitude floatValue], [station.longitude floatValue]);
        [self initTemperatureColors];
        self.icon = [ self generateMarkerByIntValue:station.lastMeasure.temp];
        self.opacity = 0.9f;
        
        
    }
    return self;
}

-(void)initTemperatureColors{
    temperatureColors = @{
                          @"-10": [NSNumber numberWithInt:0x0000FF],
                          @"-9": [NSNumber numberWithInt:0x001FFF],
                          @"-8": [NSNumber numberWithInt:0x003EFF],
                          @"-7": [NSNumber numberWithInt:0x005DFF],
                          @"-6": [NSNumber numberWithInt:0x007CFF],
                          @"-5": [NSNumber numberWithInt:0x009BFF],
                          @"-4": [NSNumber numberWithInt:0x00B9FF],
                          @"-3": [NSNumber numberWithInt:0x00D8FF],
                          @"-2": [NSNumber numberWithInt:0x00F8FF],
                          @"-1": [NSNumber numberWithInt:0x01F9E9],
                          @"0": [NSNumber numberWithInt:0x02EFCC],
                          @"1": [NSNumber numberWithInt:0x03E6AF],
                          @"2": [NSNumber numberWithInt:0x04DC92],
                          @"3": [NSNumber numberWithInt:0x05D16E],
                          @"4": [NSNumber numberWithInt:0x06C850],
                          @"5": [NSNumber numberWithInt:0x06BF33],
                          @"6": [NSNumber numberWithInt:0x07B516],
                          @"7": [NSNumber numberWithInt:0x1EBA0E],
                          @"8": [NSNumber numberWithInt:0x3BC30C],
                          @"9": [NSNumber numberWithInt:0x58CC09],
                          @"10": [NSNumber numberWithInt:0x75D507],
                          @"11": [NSNumber numberWithInt:0x92DD06],
                          @"12": [NSNumber numberWithInt:0xAFE605],
                          @"13": [NSNumber numberWithInt:0xCCEF03],
                          @"14": [NSNumber numberWithInt:0xE9F901],
                          @"15": [NSNumber numberWithInt:0xFFFC00],
                          @"16": [NSNumber numberWithInt:0xFFF100],
                          @"17": [NSNumber numberWithInt:0xFFE600],
                          @"18": [NSNumber numberWithInt:0xFFBB00],
                          @"19": [NSNumber numberWithInt:0xFFB000],
                          @"20": [NSNumber numberWithInt:0xFFA500],
                          @"21": [NSNumber numberWithInt:0xFF9100],
                          @"22": [NSNumber numberWithInt:0xFF7D00],
                          @"23": [NSNumber numberWithInt:0xFF6900],
                          @"24": [NSNumber numberWithInt:0xFF5000],
                          @"25": [NSNumber numberWithInt:0xFF3C00],
                          @"26": [NSNumber numberWithInt:0xFF2800],
                          @"27": [NSNumber numberWithInt:0xFF1300],
                          @"28": [NSNumber numberWithInt:0xFF0000],
                          @"29": [NSNumber numberWithInt:0xEC0010],
                          @"30": [NSNumber numberWithInt:0xD60021],
                          @"31": [NSNumber numberWithInt:0xC20031],
                          @"32": [NSNumber numberWithInt:0xAE0042],
                          @"33": [NSNumber numberWithInt:0x990052],
                          @"34": [NSNumber numberWithInt:0x850063],
                          @"35": [NSNumber numberWithInt:0x700073],
                          @"36": [NSNumber numberWithInt:0x5C0084]
                          };
}

-(CGColorRef)colorByTemperature:(NSNumber* ) aTemperature{
    NSNumber * hexColor = [temperatureColors objectForKey:[NSString stringWithFormat:@"%i",[aTemperature intValue]]];
    // NSNumber * hexColor = [temperatureColors objectForKey:@"28"];
    NSLog(@"For key %@, color:",[NSString stringWithFormat:@"%i",[aTemperature intValue]]);
    NSLog(@"hexColor: %@",hexColor);
    return UIColorFromRGBWithAlpha([hexColor intValue],1.0f).CGColor;
    
    
}
-(UIImage *)generateMarkerByIntValue:(NSNumber *)aValue{


    SCMarkerLabel *label = [[SCMarkerLabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.text = (aValue)?[NSString stringWithFormat:@"%.0f°",[aValue floatValue]]:@"";
    
    
    label.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:13.0f];
    static UIImage *blueCircle = nil;
    CGRect rect = CGRectMake(0, 0, 30, 30);
    CGFloat lineWidth = 2;
    CGRect borderRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 30), NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, [self colorByTemperature:aValue]);
    CGContextFillEllipseInRect(ctx, rect);
    CGContextRestoreGState(ctx);
    blueCircle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    label.backgroundColor = [UIColor colorWithPatternImage:blueCircle];
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return icon;
}
@end
