//
//  Items.m
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

-(id)initWithProduct:(Product *)product count:(NSInteger )count
{
    if (self) {
        _product = product;
        _count = count;
    }
    return self;
}

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
