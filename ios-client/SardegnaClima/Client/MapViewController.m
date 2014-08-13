#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import "MapViewController.h"
#import "SardegnaClimaViewController.h"
#import "SCApiManager.h"


#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()<GMSMapViewDelegate>
@end

@implementation MapViewController {
  
  UIView *_contentView;
    GMSMapView * _mapView;
}
@synthesize shareButton;
static const float TOOL_BAR_HEIGHT = 56.0f;




-(id)init{
    self = [super init];
    if(self){

        self.title = @"Map view";
        self.tabBarItem.image = [UIImage imageNamed:@"map-25.png"];
        
        shareButton = [[UIButton alloc]init];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"share-25.png"] forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(shareButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
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

-(void)addMarkers{
    GMSMarker *marker;
    marker.map = nil;
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(40.120878, 9.412910);
    marker.map = _mapView;
    marker.icon = [ self generateMarkerByValue:@"25"];
    
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
    // TODO: generate object to share
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
}
-(void)sardegnaClimaButtonDidClicked{
  
    SardegnaClimaViewController * sardegnaClimaViewController = [[SardegnaClimaViewController alloc]init] ;
	[self.navigationController pushViewController:sardegnaClimaViewController animated:YES];

}



-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view setAutoresizesSubviews:YES];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    self.view.autoresizingMask =
    UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view setAutoresizesSubviews:YES];
    
    
 
    static const float SHARE_BUTTON_MARGIN = 20.0f;
    static const float SHARE_BUTTON_SIDE_SIZE = 25.0f;
    [shareButton setFrame:CGRectMake(self.view.frame.size.width - SHARE_BUTTON_SIDE_SIZE - SHARE_BUTTON_MARGIN, SHARE_BUTTON_MARGIN, SHARE_BUTTON_SIDE_SIZE, SHARE_BUTTON_SIDE_SIZE)];
    // ------ bof toolbar ----- //
    /*
     
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:[self toolBarFrame]];
    toolbar.tintColor = [UIColor blackColor];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    // map button
    UIButton *MapBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0, 25.0)];
    [MapBtn setBackgroundImage:[UIImage imageNamed:@"map-25"] forState:UIControlStateNormal];
    MapBtn.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *MapBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:MapBtn];
    
    // sardegna clima button
    UIButton *SardegnaClimaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0, 25.0)];
    [SardegnaClimaButton setBackgroundImage:[UIImage imageNamed:@"partly_cloudy_day-25"] forState:UIControlStateNormal];
    SardegnaClimaButton.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *SardegnaClimaBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:SardegnaClimaButton];
    [SardegnaClimaButton addTarget:self action:@selector(sardegnaClimaButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Share button
    UIButton * ShareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0, 25.0)];
    [ShareButton setBackgroundImage:[UIImage imageNamed:@"share-25"] forState:UIControlStateNormal];
    ShareButton.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *ShareBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ShareButton];
    [ShareButton addTarget:self action:@selector(shareButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Credits button
    UIButton * CreditsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0, 25.0)];
    [CreditsButton setBackgroundImage:[UIImage imageNamed:@"info-25"] forState:UIControlStateNormal];
    CreditsButton.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *CreditsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:CreditsButton];
    
    // spacer button
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *toolbarItems = [NSArray arrayWithObjects:flexibleSpace,MapBarButtonItem,flexibleSpace,SardegnaClimaBarButtonItem ,flexibleSpace ,ShareBarButtonItem,flexibleSpace,  CreditsBarButtonItem,flexibleSpace, nil];
    [toolbar setItems:toolbarItems animated:YES];
    
    [self.view addSubview:toolbar];
     */
    
    // ------ eof toolbar ----- //
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [super viewDidLoad];
    //self.title = NSLocalizedString(@"Fonni", @"Fonni");
    //self.title = [NSString stringWithFormat:@"%@: %@", self.title, @"35 °C"];
    self.view.autoresizingMask =
    UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.120878
                                                          longitude:9.012910
                                                               zoom:8.5];
    
    _mapView = [GMSMapView mapWithFrame:[self mapFrame] camera:camera];
    _mapView.mapType = kGMSTypeTerrain;
    
    //_mapView.layer.borderWidth =2;
    //_mapView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [_mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self createContentView];
    [self addMarkers];
    _mapView.delegate = self;
    NSLog(@"navigation controller height: %f" ,self.navigationController.navigationBar.frame.size.height);
    
    [self.view addSubview:_mapView];

}
-(CGRect)mapFrame{
    CGRect screenBounds = self.view.bounds;
    CGRect frame =  CGRectMake(0.0f,
                               0.0f,
                               screenBounds.size.width,
                               screenBounds.size.height - TOOL_BAR_HEIGHT);
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

- (UIView *)mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker {
    NSLog(@"%@",marker);
    return _contentView;
}



@end
