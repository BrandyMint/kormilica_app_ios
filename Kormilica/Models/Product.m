//
//  Product.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)setTitle:(NSString *)title
{
    if ( _title.length == 0 || [_title isEqualToString:title]) {
        _title = title;
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _idProduct = [decoder decodeIntegerForKey:@"idProduct"];
        _idCategory = [decoder decodeIntegerForKey:@"idCategory"];
        _title = [decoder decodeObjectForKey:@"title"];
        _updated_at = [decoder decodeObjectForKey:@"updated_at"];
        _position = [decoder decodeIntegerForKey:@"position"];
        _price = [decoder decodeObjectForKey:@"price"];
        _image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:_idProduct forKey:@"idProduct"];
    [encoder encodeInteger:_idCategory forKey:@"idCategory"];
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_updated_at forKey:@"updated_at"];
    [encoder encodeInteger:_position forKey:@"position"];
    [encoder encodeObject:_price forKey:@"price"];
    [encoder encodeObject:_image forKey:@"image"];
}

@end
