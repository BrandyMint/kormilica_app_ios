//
//  Card.m
//  Kormilica
//
//  Created by Viktor Bespalov on 11/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Cart.h"
#import "Product.h"

@implementation Cart

-(NSArray *)getItems
{
    if (_items.count == 0) {
        NSArray* emptyArray = [NSArray new];
        return emptyArray;
    }
    return _items;
}

-(NSInteger)getItemsCount
{
    return _items.count;
}

-(Money *)getTotalPrice
{
    CGFloat sum = 0;
    for (Item* item in _items) {
        
        sum += item.count * item.product.price.cents;
    }

    Money* money = [[Money alloc]initWithCents:sum currency:@"RUB"];
    
    return money;
}

-(void)addProduct:(Product *)product count:(NSInteger )count;
{
    
    if (_items.count == 0 && count == 0) {
        //DeleteNotExistenProductByZeroCount
        NSArray* emptyArray = [NSArray new];
        _items = emptyArray;
        return;
    }
    
    //для продуктов, которые уже есть в корзине
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:_items];
    for (int i = 0; i < _items.count; i++) {
        Item* items = [_items objectAtIndex:i];
        if (items.product.idProduct == product.idProduct) {
            items.count = count;
            if (count == 0) {
                [arr removeObjectAtIndex:i];
            }
            else {
                [arr replaceObjectAtIndex:i withObject:items];
            }
            _items = arr;
            return;
        }
    }
    
    //если нет продукта с таким id, добавляем
    Item* items = [[Item alloc] initWithProduct:product count:count];
    [arr addObject:items];
    
    _items = arr;
}

-(void)deleteProduct:(Product *)product
{
    [self addProduct:product count:0];
}

-(void)removeAllProduct{
    NSArray* emptyArray = [NSArray new];
    _items = emptyArray;
}

-(void)saveCart
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self getItems]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Items"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadCart
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Items"];
    NSArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _items = array;
}

@end
