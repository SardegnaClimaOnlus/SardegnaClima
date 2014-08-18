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
        self.icon = [ self generateMarkerByIntValue:station.lastMeasure.temp];
        self.opacity = 0.7f;
        
    }
    return self;
}

-(UIImage *)generateMarkerByIntValue:(NSNumber *)aValue{
    SCMarkerLabel *label = [[SCMarkerLabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.text = (aValue)?[NSString stringWithFormat:@"%.0f",[aValue floatValue]]:@"";
    
    [label setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    static UIImage *blueCircle = nil;
    static dispatch_once_t onceToken;
    CGRect rect = CGRectMake(0, 0, 30, 30);
    CGFloat lineWidth = 2;
    CGRect borderRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 30), NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, UIColorFromRGBWithAlpha(0x59ABE3,1.0f).CGColor);
        CGContextFillEllipseInRect(ctx, rect);
        CGContextRestoreGState(ctx);
        blueCircle = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    label.backgroundColor = [UIColor colorWithPatternImage:blueCircle];
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return icon;
}
@end
