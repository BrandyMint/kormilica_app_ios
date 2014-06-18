//
//  Price.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Money.h"

@implementation Money

-(id)initWithCents:(NSInteger )cents currency:(NSString *)currency
{
    _cents = cents;
    _currency = currency;
    return self;
}
/*
-(void)setCents:(NSInteger)cents
{
    if ( _cents == 0 || _cents == cents) {
        _cents = cents;
    }
}

-(void)setCurrency:(NSString *)currency
{
    if ( _currency.length == 0 || [_currency isEqualToString:currency]) {
        _currency = currency;
    }
}
*/
-(BOOL)isEqualToMoney:(Money *)money
{
    if (_cents == money.cents && [_currency isEqualToString:money.currency]) {
        return YES;
    }
    return NO;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _currency = [decoder decodeObjectForKey:@"currency"];
        _cents = [decoder decodeIntegerForKey:@"cents"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_currency forKey:@"currency"];
    [encoder encodeInteger:_cents forKey:@"cents"];
}

@end
