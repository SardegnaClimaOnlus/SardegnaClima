#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif



#import "MapViewController.h"
#import "SardegnaClimaViewController.h"
#import "SCStationViewController.h"
#import "SCMapView.h"
#import "SCMarker.h"



#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()<GMSMapViewDelegate>
@end

@implementation MapViewController {
  
    UIView *_contentView;
    SCMapView * _mapView;
}
@synthesize shareButton;
@synthesize stations;
static const float TOOL_BAR_HEIGHT = 56.0f;




-(id)init{
    self = [super init];
    if(self){

        self.title = @"Map";
        self.tabBarItem.image = [UIImage imageNamed:@"map-25.png"];
        shareButton = [[UIButton alloc]init];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(shareButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        _mapView = [[SCMapView alloc]init];
        [self.view addSubview:shareButton];
    }
    return self;
}

-(UIImage *)generateMarkerByValue:(NSString * )aValue{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    label.text = aValue;
    static UIImage *blueCircle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(25.f, 25.f), NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGRect rect = CGRectMake(0, 0, 25, 25);
        CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
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


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
-(void)createContentView{
    _contentView = [[UIView alloc]init];
    UILabel * title = [[UILabel alloc]init];
    [title setFrame:CGRectMake(0, 0, 200, 30)];
    [title setText:@"this is the title"];
    [_contentView addSubview:title];
    UIButton * button = [[UIButton alloc]init];
    [button setTitle:@"Touch me" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(50, 40, 100, 20)];
    [button setBackgroundColor:[UIColor grayColor]];
    [_contentView addSubview:button];
    [_contentView setFrame:CGRectMake(0, 0, 200, 100)];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)orientationChanged:(NSNotification *)notification
{
    NSLog(@"orientationChanged MapViewController");
}
// --- interface orientatino --- //


-(void)shareButtonDidClicked{
    SardegnaClimaViewController * sardegnaClimaViewController = [[SardegnaClimaViewController alloc]init] ;
	[self.navigationController pushViewController:sardegnaClimaViewController animated:YES];
    
    // TODO: generate object to share
    /*
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[@"hello"] applicationActivities:nil];
    
    NSArray *excludedActivities = @[//UIActivityTypePostToTwitter,
                                    //UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    //UIActivityTypeMessage,
                                    //UIActivityTypeMail,
                                    UIActivityTypePrint,
                                    UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact,
                                    UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList,
                                    UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo,
                                    UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    [self presentViewController:controller animated:YES completion:nil];
     */
}
-(void)sardegnaClimaButtonDidClicked{
    SardegnaClimaViewController * sardegnaClimaViewController = [[SardegnaClimaViewController alloc]init] ;
	[self.navigationController pushViewController:sardegnaClimaViewController animated:YES];
}

-(void)setStations:(NSArray *)aStations{
    stations = aStations;
    [_mapView showStationInMap:stations];
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    // manage screen rotations, TODO: to clean
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    self.view.autoresizingMask =
    UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view setAutoresizesSubviews:YES];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    // share button, TODO: to change with logo
    static const float SHARE_BUTTON_MARGIN = 20.0f;
    static const float SHARE_BUTTON_SIDE_WIDTH_IPHONE = 110;
    static const float SHARE_BUTTON_SIDE_HEIGTH_IPHONE = 60;
    static const float SHARE_BUTTON_SIDE_WIDTH_IPAD = 220;
    static const float SHARE_BUTTON_SIDE_HEIGTH_IPAD = 120;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
      [shareButton setFrame:CGRectMake( SHARE_BUTTON_MARGIN, SHARE_BUTTON_MARGIN, SHARE_BUTTON_SIDE_WIDTH_IPAD, SHARE_BUTTON_SIDE_HEIGTH_IPAD)];
    else
      [shareButton setFrame:CGRectMake( SHARE_BUTTON_MARGIN, SHARE_BUTTON_MARGIN, SHARE_BUTTON_SIDE_WIDTH_IPHONE, SHARE_BUTTON_SIDE_HEIGTH_IPHONE)];

    
    // hide status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [super viewDidLoad];


    [_mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_mapView setFrame:[self mapFrame]];
    _mapView.delegate = self;
     
    
    [self.view addSubview:_mapView];
    
    // Lat/long limits (bounding box)
    leftLong = 8.1;
    rightLong = 10.1;
    bottomLat  = 38.8;
    topLat  = 41.3;
    
    // coordinates based on coordinate limits for bounding box drawn as polyline
    topLeft     = CLLocationCoordinate2DMake(topLat, leftLong);
    topRight    = CLLocationCoordinate2DMake(topLat, rightLong);
    bottomLeft  = CLLocationCoordinate2DMake(bottomLat, leftLong);
    bottomRight = CLLocationCoordinate2DMake(bottomLat, rightLong);
}
-(CGRect)mapFrame{
    CGRect screenBounds = self.view.bounds;
    CGRect frame =  CGRectMake(0.0f,
                               0.0f,
                               screenBounds.size.width,
                               screenBounds.size.height );
    return frame;
}

-(CGRect)toolBarFrame{
    CGRect screenBounds =[[UIScreen mainScreen] bounds];
    CGRect frame =  CGRectMake(0.0f,
                               screenBounds.size.height - TOOL_BAR_HEIGHT,
                               screenBounds.size.width,
                               TOOL_BAR_HEIGHT);
    return frame;
}

#pragma mark GMSMapViewDelegate
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
  return nil;
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoContents:(SCMarker *)marker {
    NSLog(@"%@",marker.station.name);
    
    return nil;
    //SCStationView * markerContentView = [[SCMarkerContentView alloc]initWithStation:marker.station];

   // return markerContentView;
}

-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(SCMarker *)marker
{
    NSLog(@"clicked marker");
    NSLog(@"station name: %@", marker.station.name );
    SCStationViewController * stationViewController = [[SCStationViewController alloc]initWithStation:marker.station] ;
	[self.navigationController pushViewController:stationViewController animated:YES];
    
    // push view controller here
    return YES;
}

// Sardinia Area
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
    
    
    // Reposition GMSMarker introduced in viewDidLoad to updated position
    currentPosition.position = position.target;
    
    // The interesting part - a non-elegant way to detect which limit was passed
    // If each of lat/long limits is passed, map will move or animate to limiting position
    
    if (position.target.latitude > topLat) { // If you scroll past upper latitude
        // Create new campera position AT upper latitude and current longitude (and zoom)
        GMSCameraPosition *goBackCamera = [GMSCameraPosition cameraWithLatitude:topLat
                                                                      longitude:position.target.longitude
                                                                           zoom:position.zoom];
        // Now, you can go back without animation,
        //self.mapView.camera = goBackCamera;
        
        // or with animation, as you see fit.
        [mapView animateToCameraPosition:goBackCamera];
    }
    
    if (position.target.latitude < bottomLat) {
        GMSCameraPosition *goBackCamera = [GMSCameraPosition cameraWithLatitude:bottomLat
                                                                      longitude:position.target.longitude
                                                                           zoom:position.zoom];
        //self.mapView.camera = goBackCamera;
        [mapView animateToCameraPosition:goBackCamera];
    }
    
    if (position.target.longitude > rightLong) {
        GMSCameraPosition *goBackCamera = [GMSCameraPosition cameraWithLatitude:position.target.latitude
                                                                      longitude:rightLong
                                                                           zoom:position.zoom];
        //self.mapView.camera = goBackCamera;
        [mapView animateToCameraPosition:goBackCamera];
    }
    
    if (position.target.longitude < leftLong) {
        GMSCameraPosition *goBackCamera = [GMSCameraPosition cameraWithLatitude:position.target.latitude
                                                                      longitude:leftLong
                                                                           zoom:position.zoom];
        //self.mapView.camera = goBackCamera;
        [mapView animateToCameraPosition:goBackCamera];
    }
    
    
}

@end
