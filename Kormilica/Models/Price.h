//
//  Price.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Price : NSObject

@property (nonatomic, assign) NSInteger cents;
@property (nonatomic, strong) NSString* currency;

@end

/*
"cents": 0,
"currency": "RUB"
*/