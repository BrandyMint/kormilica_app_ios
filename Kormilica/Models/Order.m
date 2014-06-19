//
//  Order.m
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Order.h"
#import "CartItem.h"

@implementation Order

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _items = [decoder decodeObjectForKey:@"items"];
        _total_price = [decoder decodeObjectForKey:@"total_price"];
        _address = [decoder decodeObjectForKey:@"address"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_items forKey:@"items"];
    [encoder encodeObject:_total_price forKey:@"total_price"];
    [encoder encodeObject:_address forKey:@"address"];
}

-(id)initWithCartItems:(NSArray *)cartItems total_price:(Money *)total_price fromProducts:(NSArray *)products
{
    if (self == [super init]) {
        Address* address = [Address new];
        _address = address;
        _total_price = total_price;
        [self setOrderItems:cartItems fromProducts:products];
    }
    return self;
}

-(void)setOrderItems:(NSArray *)cartItems fromProducts:(NSArray *)products
{
    NSMutableArray* orderItemsArray = [[NSMutableArray alloc] init];
    for (CartItem* cartItem in cartItems) {
        for (Product* product in products) {
            if (cartItem.idProduct == product.idProduct) {
                OrderItem* orderItem = [[OrderItem alloc] initWithProduct:product count:cartItem.count];
                [orderItemsArray addObject:orderItem];
            }
        }
    }
    _items = orderItemsArray;
}

-(NSArray *)getItems
{
    return _items;
}

-(void)updateOrderWithCart:(Cart *)cart;
{
    CGFloat sum = 0;
    for (OrderItem* orderItem in _items) {
        for (CartItem* cartItem in cart.items) {
            orderItem.count = cartItem.count;
            
        }
    }
    
    NSMutableArray* orderItemsArray = [[NSMutableArray alloc] initWithArray:_items];
    for (int i = 0; i < orderItemsArray.count; i++) {
        OrderItem* orderItem = [orderItemsArray objectAtIndex:i];
        if  (cart.items.count == 0)
        {
            [orderItemsArray removeAllObjects];
        }
        
        for (CartItem* cartItem in cart.items) {
            if (orderItem.product.idProduct == cartItem.idProduct && orderItem.count != cartItem.count) {
                orderItem.count = cartItem.count;
                [orderItemsArray replaceObjectAtIndex:i withObject:orderItem];
            }
        }
        sum += orderItem.count * orderItem.product.price.cents;
    }
    _items = orderItemsArray;
    _total_price = [[Money alloc]initWithCents:sum/100 currency:@"RUB"];
    
}

-(void)saveOrder
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Order"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(Order *)loadOrder
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Order"];
    Order* loadOrder = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return loadOrder;
}

@end
