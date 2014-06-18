//
//  Order.m
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Order.h"

@implementation Order

-(void)setTotal_price:(Money *)money
{
    _total_price = money;
}

-(Money *)getTotal_price
{
    return _total_price;
}

-(void)setItems:(NSArray *)items
{
    if (_items.count == 0) {
        _items = items;
        return;
    }
    
    NSMutableArray* itemMutable = [[NSMutableArray alloc] initWithArray:_items];
    
    for (Item* item in itemMutable) {
        for (Item* itemNew in items) {
            if (item.idProduct == itemNew.idProduct) {
                //не меняем продукт в заказе
            }
            else {
                //добавил в заказ
                [itemMutable addObject:itemNew];
            }
        }
    }
    
    _items = itemMutable;
}

-(NSArray *)getItems
{
    return _items;
}

@end
