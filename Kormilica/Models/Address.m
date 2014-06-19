//
//  Address.m
//  Kormilica
//
//  Created by Viktor Bespalov on 19/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Address.h"

@implementation Address

- (id)init
{
    self = [super init];
    if (self) {
        _city = @"Чебоксары";
        _phone = @"";
        _address = @"";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _phone = [decoder decodeObjectForKey:@"phone"];
        _city = [decoder decodeObjectForKey:@"city"];
        _address = [decoder decodeObjectForKey:@"address"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_phone forKey:@"phone"];
    [encoder encodeObject:_city forKey:@"city"];
    [encoder encodeObject:_address forKey:@"address"];
}


@end
