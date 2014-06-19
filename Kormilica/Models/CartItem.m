//
//  CartItem.m
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "CartItem.h"
#import "Cart.h"
#import "CartItem.h"

@implementation CartItem

-(id)initWithIdProduct:(NSInteger )idProduct count:(NSInteger )count;
{
    if (self) {
        _idProduct = idProduct;
        _count = count;
    }
    return self;
}

-(Product *)productFromAllProducts:(NSArray *)allProduct;
{
    // Лезет в базу и ищет продукт по idProduct
    for (Product* product in allProduct) {
        if (_idProduct == product.idProduct) {
            return product;
        }
    }
    return nil;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _count = [decoder decodeIntegerForKey:@"count"];
        _idProduct = [decoder decodeIntegerForKey:@"idProduct"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:_count forKey:@"count"];
    [encoder encodeInteger:_idProduct forKey:@"idProduct"];
}

@end
