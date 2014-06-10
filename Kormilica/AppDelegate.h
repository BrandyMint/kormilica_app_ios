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

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) Bundles* bundles;
@property (nonatomic, strong) Managers* managers;
@property (nonatomic, strong) ConvertTime* convertTime;

@property (nonatomic, assign) BOOL succesOrFailOrder;

@end
