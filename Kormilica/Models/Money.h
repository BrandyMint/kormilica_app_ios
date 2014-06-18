//
//  Price.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Money : NSObject

@property (nonatomic, assign) NSInteger cents;
@property (nonatomic, strong) NSString* currency;

-(id)initWithCents:(NSInteger )cents currency:(NSString *)currency;
-(BOOL)isEqualToMoney:(Money *)money;

@end

/*
"cents": 0,
"currency": "RUB"
*/