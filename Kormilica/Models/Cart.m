//
//  Card.m
//  Kormilica
//
//  Created by Viktor Bespalov on 11/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Cart.h"
#import "Product.h"
#import "CartItem.h"

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

-(Money *)getTotalPriceFromProducts:(NSArray *)products
{
    CGFloat sum = 0;
    for (CartItem* cartItem in _items) {
        Product* product = [cartItem productFromAllProducts:products];
        sum += cartItem.count * product.price.cents;
    }
    
    Money* money = [[Money alloc]initWithCents:sum/100 currency:@"RUB"];
    return money;
}

-(BOOL)isAllowedOrderFromProducts:(NSArray *)products
{
    Money* totalPrice = [self getTotalPriceFromProducts:products];
    
    if (totalPrice.cents >= _vendor.minimal_price.cents/100) {
        return YES;
    }
    return NO;
}

-(void)addIdProduct:(NSInteger )idProduct count:(NSInteger )count;
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
        CartItem* items = [_items objectAtIndex:i];
        if (items.idProduct == idProduct) {
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
    CartItem* items = [[CartItem alloc] initWithIdProduct:idProduct count:count];
    [arr addObject:items];
    
    _items = arr;
}

-(void)deleteProduct:(Product *)product
{
    [self addIdProduct:product.idProduct count:0];
}

-(void)removeAllProduct{
    NSArray* emptyArray = [NSArray new];
    _items = emptyArray;
}

-(NSInteger)countProductInCartWithIdProduct:(NSInteger )idProduct
{
    for (CartItem* cartItem in _items)
    {
        if (idProduct == cartItem.idProduct) {
            return cartItem.count;
        }
    }
    return 0;
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
