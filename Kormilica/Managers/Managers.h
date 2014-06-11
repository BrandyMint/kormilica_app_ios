//
//  Managers.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bundles.h"

@interface Managers : NSObject

//Пакет данных по вендору
- (void) getBundles:(void (^) (Bundles* bundles)) block  failBlock:(void (^) (NSException *exception)) blockException;
-(void)getLocalBundles:(void (^) (Bundles* bundles))block;

@end
