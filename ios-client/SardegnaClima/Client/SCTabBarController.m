//
//  SCTabBarController.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 10/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//



#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import "SCTabBarController.h"

@interface SCTabBarController ()

@end

@implementation SCTabBarController
@synthesize mapViewController, sardegnaClimaViewController, creditsViewController;
@synthesize stations;

-(id)init{
    self = [super init];
    if(self){
        mapViewController = [[MapViewController alloc] init];
        sardegnaClimaViewController = [[SardegnaClimaViewController alloc]init];
        creditsViewController = [[CreditsViewController alloc] init];
        NSArray * tabViewControllers = [[NSArray alloc]initWithObjects:mapViewController,sardegnaClimaViewController, creditsViewController, nil];
        [self setViewControllers:tabViewControllers];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setStations:(NSArray *)aStations{
    stations = aStations;
    [mapViewController setStations:stations];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)orientationChanged:(NSNotification *)notification
{
    NSLog(@"orientationChanged SCTabBarController");
}

- (void)viewDidLoad
{
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
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    NSLog(@"SCTabBarController");
    NSLog(@"self.tabBar.frame.size.height: %f", self.tabBar.frame.size.height);

    
    
    CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.tabBar.frame.size.height);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    [v setBackgroundColor:UIColorFromRGBWithAlpha(0x34495E, 1.0f)];
    [[self tabBar] addSubview:v];
    
 

    UIColor * selectedColor = UIColorFromRGBWithAlpha(0xECF0F1, 1.0f);
    
    [[UITabBar appearance] setSelectedImageTintColor:selectedColor]; //
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedColor} forState:UIControlStateSelected];
    
    
    // doing this results in an easier to read unselected state then the default iOS 7 one
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : UIColorFromRGBWithAlpha(0x929292,1.0f)
                                                        } forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
