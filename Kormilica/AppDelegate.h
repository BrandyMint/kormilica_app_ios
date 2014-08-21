//
//  AppDelegate.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Managers.h"
#import "ConvertTime.h"
#import "Cart.h"
#import "CreateOrderToJson.h"
#import "NUIAppearance.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) Bundles* bundles;
@property (nonatomic, strong) Managers* managers;
@property (nonatomic, strong) ConvertTime* convertTime;
@property (nonatomic, strong) Cart* cart;
@property (nonatomic, strong) CreateOrderToJson* createOrderToJson;

@property (nonatomic, assign) BOOL succesOrFailOrder;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;

@end
