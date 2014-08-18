#import <UIKit/UIKit.h>
#import "../SCMapManager.h"

@class SDKDemoAppDelegate;

@interface MapViewController : UIViewController
{
 
    GMSMarker *currentPosition;
    CLLocationCoordinate2D center, topLeft, topRight, bottomLeft, bottomRight;
    double leftLong, rightLong, bottomLat, topLat;
    

    
}
@property (nonatomic, assign) SDKDemoAppDelegate *appDelegate;
@property(strong, nonatomic)UIButton * shareButton;
@property(strong, nonatomic)NSArray * stations;
@end
