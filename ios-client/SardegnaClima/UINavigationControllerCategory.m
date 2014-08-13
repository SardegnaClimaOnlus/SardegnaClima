//
//  UINavigationControllerCategory.m
//  001-navigationController
//
//  Created by Raffaele Bua on 25/02/14.
//

#import "UINavigationControllerCategory.h"

@implementation UINavigationController (bueleRotationCategory)

-(NSUInteger)supportedInterfaceOrientations
{
    // FIXME: check variables
    if (self.viewControllers != NULL && [self.viewControllers lastObject] != NULL)
        return [[self.viewControllers lastObject] supportedInterfaceOrientations];
    else
        return UIDeviceOrientationPortrait;

}

@end
