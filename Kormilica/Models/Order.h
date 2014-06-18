//
//  Order.h
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.h"
#import "Item.h"

@interface Order : NSObject

@property (nonatomic, readonly) NSArray* items;
@property (nonatomic, readonly) Money* total_price;
@property (nonatomic, assign) NSString* address;
@property (nonatomic, assign) NSString* telephone;

-(void)setTotal_price:(Money *)money;
-(Money *)getTotal_price;

-(void)setItems:(NSArray *)items;
-(NSArray *)getItems;

@end
