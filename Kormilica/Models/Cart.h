//
//  Card.h
//  Kormilica
//
//  Created by Viktor Bespalov on 11/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Item.h"
#import "Money.h"

@interface Cart : NSObject

@property (nonatomic, readonly) NSArray* items;

-(NSArray *)getItems;
-(NSInteger)getItemsCount;
-(Money *)getTotalPrice;

-(void)addProduct:(Product *)product count:(NSInteger )count;
-(void)deleteProduct:(Product *)product;

-(void)removeAllProduct;

-(void)saveCart;
-(void)loadCart;

@end
