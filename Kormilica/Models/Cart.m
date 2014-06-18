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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _items = [decoder decodeObjectForKey:@"items"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_items forKey:@"items"];
}

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
    for (OrderItem* item in _items) {
        
        sum += item.count * item.product.price.cents;
    }

    Money* money = [[Money alloc]initWithCents:sum currency:@"RUB"];
    
    return money;
}

-(BOOL)isAllowedOrder
{
    Money* totalPrice = [self getTotalPrice];
    if (totalPrice.cents >= _vendor.minimal_price.cents) {
        return YES;
    }
    return NO;
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
        OrderItem* items = [_items objectAtIndex:i];
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
    OrderItem* items = [[OrderItem alloc] initWithProduct:product count:count];
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
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Cart"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(Cart *)loadCart
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cart"];
    Cart* cart = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //_items = array;
    return cart;
}

@end
