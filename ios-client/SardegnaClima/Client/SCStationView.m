//
//  SCStationView.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 19/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCStationView.h"


#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation SCStationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:UIColorFromRGBWithAlpha( 0x557187,1)];
    }
    return self;
}


-(void)setBorders:(UIView *)aView{
    if(showBorders){
        aView.layer.borderColor = [UIColor redColor].CGColor;
        aView.layer.borderWidth = 1.0f;
    }
    
}

-(NSString *)getWindDirectionByChar:(NSString *)aDirection{
    return [windDirections objectForKey:aDirection];
    
}
-(id)initWithStation:(SCStation *)aStation{
    static const float TITLE_VERTICAL_MARGIN = 10.0f;
    static const float PROPERTY_VERTICAL_MARGIN = 10.0f;
    static const float VALUE_HORIZONTAL_MARGIN = 25.0f;
    static const float VALUE_VERTICAL_PADDING = 0.0f;
    static const float VIEW_MARGIN = 40.0f;
    static const float TEMPERATURE_TOP = 140.0f;
    static const float MAX_TEMPERATURE_TOP = 162.0f;
    static const float MIN_TEMPERATURE_TOP = 267.0f;
    static const float MAX_TEMPERATURE_HORIZONTAL_MARGIN = 330.0f;
    static const float MIN_TEMPERATURE_HORIZONTAL_MARGIN = 330.0f;
    static const float RAIN_SIZE = 80.0f;
    static const float WIND_ICON_SIZE = 80.0f;
    static const float VERTICAL_MARGIN = 50.0f;
    static const float ITEMS_VERTICAL_MARGIN = 60.0f;
    static  NSString * FONT_FAMILY = @"Helvetica";
    static  NSString * LABEL_FONT_FAMILY = @"Helvetica-Bold";
    
    static const float  FONT_SIZE = 16.0f;
    static const float  TITLE_FONT_SIZE = 18.0f;
    self = [super init];
    if(self){
        station = aStation;
        [self setFrame:CGRectMake(0, 0, 300, 200)];
        showBorders = NO;
        
        windDirections = @{@"W":@"←",@"NW":@"↖",@"N":@"↑",@"NE":@"↗",@"E":@"→",@"SE":@"↘",@"S":@"↓",@"SW":@"↙"};
        

        float lastY = 0.0f;
        // temperature
        UILabel * temperatureLabel = [[UILabel alloc]init];
        [temperatureLabel setFrame:CGRectMake(VIEW_MARGIN, TEMPERATURE_TOP, self.frame.size.width, 0)];
        [temperatureLabel setText:[NSString stringWithFormat:@"%.0f°",[station.lastMeasure.temp floatValue]]];
        temperatureLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:200.0f];
        [temperatureLabel setTextColor:[UIColor whiteColor]];
        [temperatureLabel sizeToFit];
        [self addSubview:temperatureLabel];
        
        // max temperature
        
        UILabel * maxTemperatureLabel = [[UILabel alloc]init];
        [maxTemperatureLabel setFrame:CGRectMake(VIEW_MARGIN + MAX_TEMPERATURE_HORIZONTAL_MARGIN, MAX_TEMPERATURE_TOP, self.frame.size.width, 0)];
        [maxTemperatureLabel setText:[NSString stringWithFormat:@"↑ %.0f°",[station.lastMeasure.tempmax floatValue]]];
        maxTemperatureLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:50.0f];
        [maxTemperatureLabel setTextColor:[UIColor whiteColor]];
        [maxTemperatureLabel sizeToFit];
        [self addSubview:maxTemperatureLabel];
        
        // min temperature
        
        UILabel * minTemperatureLabel = [[UILabel alloc]init];
        [minTemperatureLabel setFrame:CGRectMake(VIEW_MARGIN + MIN_TEMPERATURE_HORIZONTAL_MARGIN, MIN_TEMPERATURE_TOP, self.frame.size.width, 0)];
        [minTemperatureLabel setText:[NSString stringWithFormat:@"↓ %.0f°",[station.lastMeasure.tempmin floatValue]]];
        minTemperatureLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:50.0f];
        [minTemperatureLabel setTextColor:[UIColor whiteColor]];
        [minTemperatureLabel sizeToFit];
        [self addSubview:minTemperatureLabel];
        
        
        // rain icon
        UIImage *rainIconImage = [UIImage imageNamed:@"umbrella-512.png"];
        rainIconImage = [rainIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIImageView *rainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_MARGIN, TEMPERATURE_TOP + temperatureLabel.frame.size.height + ITEMS_VERTICAL_MARGIN, RAIN_SIZE, RAIN_SIZE)];
        rainImageView.tintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1];
        rainImageView.image = rainIconImage;
        [self setBorders:rainImageView];
        [self addSubview:rainImageView];
        
        // month rain
        
        UILabel * rainMonth = [[UILabel alloc]init];
        [rainMonth setFrame:CGRectMake(VIEW_MARGIN + rainImageView.frame.size.width + VALUE_HORIZONTAL_MARGIN, TEMPERATURE_TOP + temperatureLabel.frame.size.height + ITEMS_VERTICAL_MARGIN, self.frame.size.width, 0)];
        [rainMonth setText:[NSString stringWithFormat:@"m %.0f mm",[station.lastMeasure.rainmt floatValue]]];
        rainMonth.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:35.0f];
        [rainMonth setTextColor:[UIColor whiteColor]];
        [rainMonth sizeToFit];
        [self setBorders:rainMonth];
        [self addSubview:rainMonth];
        
        
        // year rain
        UILabel * rainYear = [[UILabel alloc]init];
        [rainYear setFrame:CGRectMake(VIEW_MARGIN + rainImageView.frame.size.width + VALUE_HORIZONTAL_MARGIN, rainMonth.frame.origin.y + rainMonth.frame.size.height , self.frame.size.width, 0)];
        [rainYear setText:[NSString stringWithFormat:@"y %.0f mm",[station.lastMeasure.rainyr floatValue]]];
        rainYear.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:35.0f];
        [rainYear setTextColor:[UIColor whiteColor]];
        [rainYear sizeToFit];
        [self setBorders:rainYear];
        [self addSubview:rainYear];
        
        // -------> wind
        
        
        
        // wind value ←↖↑↗→↘↓↙ getWindDirectionByChar
        UILabel * windDirectionLabel = [[UILabel alloc]init];
        [windDirectionLabel setFrame:CGRectMake(rainYear.frame.origin.x + rainYear.frame.size.width + VALUE_HORIZONTAL_MARGIN + 50.0f , TEMPERATURE_TOP + temperatureLabel.frame.size.height + ITEMS_VERTICAL_MARGIN, self.frame.size.width, 0)];
        [windDirectionLabel setText:[NSString stringWithFormat:@"%@",[self getWindDirectionByChar:station.lastMeasure.dir]]];
        windDirectionLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:85.0f];
        [windDirectionLabel setTextColor:[UIColor whiteColor]];
        [windDirectionLabel sizeToFit];
        [self setBorders:windDirectionLabel];
        [self addSubview:windDirectionLabel];
        
        UILabel * windLabel = [[UILabel alloc]init];
        [windLabel setFrame:CGRectMake(windDirectionLabel.frame.origin.x + windDirectionLabel.frame.size.width + VALUE_HORIZONTAL_MARGIN , TEMPERATURE_TOP + temperatureLabel.frame.size.height + ITEMS_VERTICAL_MARGIN, self.frame.size.width, 0)];
        [windLabel setText:[NSString stringWithFormat:@"%.0f",[station.lastMeasure.wspeed floatValue]]];
        windLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:85.0f];
        [windLabel setTextColor:[UIColor whiteColor]];
        [windLabel sizeToFit];
        [self setBorders:windLabel];
        [self addSubview:windLabel];
        
        // wind unit
        UILabel * windUnitLabel = [[UILabel alloc]init];
        [windUnitLabel setFrame:CGRectMake(windLabel.frame.origin.x + windLabel.frame.size.width , windLabel.frame.origin.y + 43.0f , self.frame.size.width, 0)];
        [windUnitLabel setText:[NSString stringWithFormat:@" km/h"]];
        windUnitLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:35.0f];
        [windUnitLabel setTextColor:[UIColor whiteColor]];
        [windUnitLabel sizeToFit];
        [self setBorders:windUnitLabel];
        [self addSubview:windUnitLabel];
        
        
        // -------> pressure
        
        // pressure icon
        UIImage *pressureIconImage = [UIImage imageNamed:@"pressure-512.png"];
        pressureIconImage = [pressureIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIImageView *pressureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rainYear.frame.origin.x + rainYear.frame.size.width + VALUE_HORIZONTAL_MARGIN + 50.0f , rainImageView.frame.origin.y + rainImageView.frame.size.height + ITEMS_VERTICAL_MARGIN, WIND_ICON_SIZE, WIND_ICON_SIZE)];
        pressureImageView.tintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1];
        pressureImageView.image = pressureIconImage;
        [self setBorders:pressureImageView];
        [self addSubview:pressureImageView];
        
        // pressure value
        
        UILabel * pressureLabel = [[UILabel alloc]init];
        [pressureLabel setFrame:CGRectMake(pressureImageView.frame.origin.x + pressureImageView.frame.size.width + VALUE_HORIZONTAL_MARGIN , rainImageView.frame.origin.y + rainImageView.frame.size.height + ITEMS_VERTICAL_MARGIN, self.frame.size.width, 0)];
        [pressureLabel setText:[NSString stringWithFormat:@"%.0f",[station.lastMeasure.bar floatValue]]];
        pressureLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:85.0f];
        [pressureLabel setTextColor:[UIColor whiteColor]];
        [pressureLabel sizeToFit];
        [self setBorders:pressureLabel];
        [self addSubview:pressureLabel];
        
        // pressure unit
        UILabel * pressureUnitLabel = [[UILabel alloc]init];
        [pressureUnitLabel setFrame:CGRectMake(pressureLabel.frame.origin.x + pressureLabel.frame.size.width , pressureLabel.frame.origin.y + 43.0f , self.frame.size.width, 0)];
        [pressureUnitLabel setText:[NSString stringWithFormat:@" mb"]];
        pressureUnitLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:35.0f];
        [pressureUnitLabel setTextColor:[UIColor whiteColor]];
        [pressureUnitLabel sizeToFit];
        [self setBorders:pressureUnitLabel];
        [self addSubview:pressureUnitLabel];
        
        
        // -------> humidity
        
        // humidity icon
        UIImage * humidityIconImage = [UIImage imageNamed:@"water-512.png"];
        humidityIconImage = [humidityIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIImageView *humidityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_MARGIN , rainImageView.frame.origin.y + rainImageView.frame.size.height + ITEMS_VERTICAL_MARGIN, WIND_ICON_SIZE, WIND_ICON_SIZE)];
        humidityImageView.tintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1];
        humidityImageView.image = humidityIconImage;
        [self setBorders:humidityImageView];
        [self addSubview:humidityImageView];
        
        // humidity value
        
        UILabel * humidityLabel = [[UILabel alloc]init];
        [humidityLabel setFrame:CGRectMake(humidityImageView.frame.origin.x+ humidityImageView.frame.size.width + VALUE_HORIZONTAL_MARGIN, rainImageView.frame.origin.y + rainImageView.frame.size.height + ITEMS_VERTICAL_MARGIN, self.frame.size.width, 0)];
        [humidityLabel setText:[NSString stringWithFormat:@"%.0f",[station.lastMeasure.hum floatValue]]];
        humidityLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:85.0f];
        [humidityLabel setTextColor:[UIColor whiteColor]];
        [humidityLabel sizeToFit];
        [self setBorders:humidityLabel];
        [self addSubview:humidityLabel];
        
        // humidity unit
        UILabel * humidityUnitLabel = [[UILabel alloc]init];
        [humidityUnitLabel setFrame:CGRectMake(humidityLabel.frame.origin.x + humidityLabel.frame.size.width , humidityImageView.frame.origin.y + 43.0f , self.frame.size.width, 0)];
        [humidityUnitLabel setText:[NSString stringWithFormat:@" %%"]];
        humidityUnitLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:35.0f];
        [humidityUnitLabel setTextColor:[UIColor whiteColor]];
        [humidityUnitLabel sizeToFit];
        [self setBorders:humidityUnitLabel];
        [self addSubview:humidityUnitLabel];
        
        
        // -------> dew point
        
        
        
        // wind value ←↖↑↗→↘↓↙ getWindDirectionByChar
        UILabel * dewPointLabel = [[UILabel alloc]init];
        [dewPointLabel setFrame:CGRectMake(VIEW_MARGIN , humidityImageView.frame.origin.y + humidityImageView.frame.size.height + ITEMS_VERTICAL_MARGIN + 10.0f, self.frame.size.width, 0)];
        [dewPointLabel setText:[NSString stringWithFormat:@"Dp"]];
        dewPointLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:60.0f];
        [dewPointLabel setTextColor:[UIColor whiteColor]];
        [dewPointLabel sizeToFit];
        [self setBorders:dewPointLabel];
        [self addSubview:dewPointLabel];
        
        UILabel * dewPointValueLabel = [[UILabel alloc]init];
        [dewPointValueLabel setFrame:CGRectMake(dewPointLabel.frame.origin.x + dewPointLabel.frame.size.width + VALUE_HORIZONTAL_MARGIN , humidityImageView.frame.origin.y + humidityImageView.frame.size.height + ITEMS_VERTICAL_MARGIN, self.frame.size.width, 0)];
        [dewPointValueLabel setText:[NSString stringWithFormat:@"%.0f°",[station.lastMeasure.dp floatValue]]];
        dewPointValueLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:85.0f];
        [dewPointValueLabel setTextColor:[UIColor whiteColor]];
        [dewPointValueLabel sizeToFit];
        [self setBorders:dewPointValueLabel];
        [self addSubview:dewPointValueLabel];
        
        

       
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
