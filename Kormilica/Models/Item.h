//
//  Items.h
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Item : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger idProduct;

@property (nonatomic, strong) Product* product;

-(id)initWithProduct:(Product *)product count:(NSInteger )count;

@end
