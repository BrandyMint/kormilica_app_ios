//
//  Order.h
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.h"
#import "OrderItem.h"

@interface Order : NSObject

@property (nonatomic, readonly) NSArray* items;
@property (nonatomic, readonly) Money* total_price;
@property (nonatomic, assign) NSString* address;
@property (nonatomic, assign) NSString* telephone;

-(id)initWithOrderItems:(NSArray *)orderItems total_price:(Money *)total_price;

-(NSArray *)getItems;

-(void)saveOrder;
-(Order *)loadOrder;

@end
