//
//  SCMarkerContentView.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 14/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCStationView.h"
#import "SCMeasure.h"

@implementation SCStationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setBordersToUIView:(UIView *)view{
    view.layer.borderColor = [UIColor brownColor].CGColor;
    view.layer.borderWidth = 1.0f;
}

-(id)initWithStation:(SCStation *)aStation{
    static const float TITLE_VERTICAL_MARGIN = 10.0f;
    static const float PROPERTY_VERTICAL_MARGIN = 10.0f;
    static const float VALUE_HORIZONTAL_MARGIN = 5.0f;
    static const float VALUE_VERTICAL_PADDING = 0.0f;
    static  NSString * FONT_FAMILY = @"Helvetica";
    static  NSString * LABEL_FONT_FAMILY = @"Helvetica-Bold";
    
    static const float  FONT_SIZE = 16.0f;
    static const float  TITLE_FONT_SIZE = 18.0f;
    self = [super init];
    if(self){
        station = aStation;
        [self setFrame:CGRectMake(0, 0, 300, 200)];
        
        // name of station
        title = [[UILabel alloc]init];
        [title setFrame:CGRectMake(0, 0, 200, 30)];
        [title setText:station.name];
        [title setFont:[UIFont fontWithName:LABEL_FONT_FAMILY size:TITLE_FONT_SIZE]];
        [title sizeToFit];
        
        //[self setBordersToUIView:title];
        
        [self addSubview:title];
        float lastY = 0.0f;
        // temperature
        // -- label
        UILabel * temperatureLabel = [[UILabel alloc]init];
        [temperatureLabel setFrame:CGRectMake(0, title.frame.size.height + TITLE_VERTICAL_MARGIN, self.frame.size.width, 0)];

        [temperatureLabel setText:[NSString stringWithFormat:@"%.2f °C",[station.lastMeasure.temp floatValue]]];
        [temperatureLabel setFont:[UIFont boldSystemFontOfSize:30.0f]];
        [temperatureLabel sizeToFit];
        //[self setBordersToUIView:temperatureLabel];
        [self addSubview:temperatureLabel];
        
        // -- value
        CGFloat valueX = temperatureLabel.frame.size.width;
        UILabel * temperatureValue = [[UILabel alloc]init];
        CGRect propertyValueFrame = CGRectMake(valueX  , title.frame.size.height + TITLE_VERTICAL_MARGIN + VALUE_VERTICAL_PADDING, self.frame.size.width, 0);
        [temperatureValue setFrame:propertyValueFrame];
        [temperatureValue setText:[NSString stringWithFormat:@"%.2f °C",[station.lastMeasure.temp floatValue]]];
        [temperatureValue setFont:[UIFont fontWithName:FONT_FAMILY size:FONT_SIZE]];
        [temperatureValue sizeToFit];
        //[self setBordersToUIView:temperatureValue];
        [self addSubview:temperatureValue];
        lastY += temperatureValue.frame.size.height + PROPERTY_VERTICAL_MARGIN;
        
        // temperature max
        // -- label
        UILabel * temperatureMaxLabel = [[UILabel alloc]init];
        [temperatureMaxLabel setFrame:CGRectMake(0, title.frame.size.height  + lastY, self.frame.size.width, 0)];
        [temperatureMaxLabel setText:[NSString stringWithFormat:@"Max: "]];
        [temperatureMaxLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [temperatureMaxLabel sizeToFit];
        //[self setBordersToUIView:temperatureLabel];
        [self addSubview:temperatureMaxLabel];
        
        // -- value
        UILabel * temperatureMaxValue = [[UILabel alloc]init];
        [temperatureMaxValue setFrame:CGRectMake(temperatureMaxLabel.frame.size.width  , title.frame.size.height  + VALUE_VERTICAL_PADDING + lastY, self.frame.size.width, 0)];
        [temperatureMaxValue setText:[NSString stringWithFormat:@"%.2f °C",[station.lastMeasure.tempmax floatValue]]];
        [temperatureMaxValue setFont:[UIFont fontWithName:FONT_FAMILY size:FONT_SIZE]];
        [temperatureMaxValue sizeToFit];
        //[self setBordersToUIView:temperatureValue];
        [self addSubview:temperatureMaxValue];
        lastY += temperatureValue.frame.size.height + TITLE_VERTICAL_MARGIN;
        
        // temperature min
        station.lastMeasure.tempmin;
        
        // humidity
        station.lastMeasure.hum;
        
        // bar
        station.lastMeasure.bar;
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
}


@end
