//
//  Bundles.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vendor.h"
#import "Categories.h"
#import "Product.h"

@interface Bundles : NSObject

@property (nonatomic, strong) Vendor* vendor;
@property (nonatomic, strong) NSArray* categories;
@property (nonatomic, strong) NSArray* products;
@property (nonatomic, strong) NSString* update;

@end
