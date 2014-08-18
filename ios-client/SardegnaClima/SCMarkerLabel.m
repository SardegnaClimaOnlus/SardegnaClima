//
//  SCMarkerLabel.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 15/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SCMarkerLabel.h"

@implementation SCMarkerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
