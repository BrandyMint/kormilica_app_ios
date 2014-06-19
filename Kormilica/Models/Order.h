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
#import "Address.h"

@interface Order : NSObject

@property (nonatomic, readonly) NSArray* items;
@property (nonatomic, readonly) Money* total_price;
@property (nonatomic, strong) Address* address;

-(id)initWithCartItems:(NSArray *)cartItems total_price:(Money *)total_price fromProducts:(NSArray *)products;
-(void)updateOrderWithCart:(Cart *)cart;

-(NSArray *)getItems;
-(void)saveOrder;
-(Order *)loadOrder;

@end
