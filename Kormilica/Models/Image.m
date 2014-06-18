//
//  Image.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Image.h"

@implementation Image

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _mobile_url = [decoder decodeObjectForKey:@"mobile_url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_mobile_url forKey:@"mobile_url"];
}

@end
