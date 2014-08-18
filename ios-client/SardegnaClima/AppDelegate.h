//
//  AppDelegate.h
//  SardegnaClima
//
//  Created by Raffaele Bua on 04/08/14.
//  Copyright (c) 2014 Buele. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Client/SCTabBarController.h"
#import "SCEntityManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SCEntityManager * em ;
    MapViewController * mapViewController;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



@property(strong, nonatomic) UINavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
