//
//  SardegnaClimaViewController.m
//  SardegnaClima
//
//  Created by Raffaele Bua on 06/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import "SardegnaClimaViewController.h"

@interface SardegnaClimaViewController ()

@end

@implementation SardegnaClimaViewController

-(id)init{
    
    self = [super init];
    if(self){
        sardegnaClimaView = [[SardegnaClimaView alloc]init];
        self.title = @"Sardegna clima ";
        self.tabBarItem.image = [UIImage imageNamed:@"partly_cloudy_day-25.png"];
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

- (void)orientationChanged:(NSNotification *)notification
{
        NSLog(@"orientationChanged SardegnaClimaViewController");
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
    [sardegnaClimaView setFrame:self.view.frame];

    [self.view addSubview:sardegnaClimaView];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    [sardegnaClimaView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    NSLog(@" view height: %f", self.view.frame.size.height);
    NSLog(@" sardegnaClimaView height: %f", sardegnaClimaView.frame.size.height);
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
