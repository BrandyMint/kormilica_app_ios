//
//  Card.h
//  Kormilica
//
//  Created by Viktor Bespalov on 11/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "OrderItem.h"
#import "Money.h"
#import "Vendor.h"

@interface Cart : NSObject

@property (nonatomic, readonly) NSArray* items;
@property (nonatomic, assign) Vendor* vendor;

-(NSArray *)getItems;
-(NSInteger)getItemsCount;
-(Money *)getTotalPrice;
-(BOOL)isAllowedOrder;

-(void)addProduct:(Product *)product count:(NSInteger )count;
-(void)deleteProduct:(Product *)product;
-(void)removeAllProduct;

-(void)saveCart;
-(Cart *)loadCart;

@end
