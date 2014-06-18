//
//  Items.m
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)initWithProduct:(Product *)product count:(NSInteger )count
{
    if (self) {
        _product = product;
        _count = count;
        _idProduct = product.idProduct;
    }
    return self;
}

/*
-(Product *)product
{
    // Лезетв базу и ищетпродуктпо idProduct
    return nil;
}
 */

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _count = [decoder decodeIntegerForKey:@"count"];
        _product = [decoder decodeObjectForKey:@"product"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:_count forKey:@"count"];
    [encoder encodeObject:_product forKey:@"product"];
}

@end
