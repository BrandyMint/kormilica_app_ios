//
//  Factory.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyMapping.h"
#import "Vendor.h"
#import "Price.h"
#import "Categories.h"
#import "Product.h"
#import "Image.h"
#import "Bundles.h"

@interface Factory : NSObject

+ (EKObjectMapping*) bundlesMapping;

+ (EKObjectMapping*) vendorMapping;
+ (EKObjectMapping*) categoriesMapping;
+ (EKObjectMapping*) productMapping;

@end
