#import <UIKit/UIKit.h>

@class SDKDemoAppDelegate;

@interface MapViewController : UIViewController
{
    BOOL isPhone_;
}
@property (nonatomic, assign) SDKDemoAppDelegate *appDelegate;
@property(strong,nonatomic)UIButton * shareButton;
@end
