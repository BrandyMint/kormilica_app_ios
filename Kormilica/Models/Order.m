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
        _telephone = [decoder decodeObjectForKey:@"telephone"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_items forKey:@"items"];
    [encoder encodeObject:_total_price forKey:@"total_price"];
    [encoder encodeObject:_address forKey:@"address"];
    [encoder encodeObject:_telephone forKey:@"telephone"];
}

-(id)initWithOrderItems:(NSArray *)orderItems total_price:(Money *)total_price
{
    if (self == [super init]) {
        _total_price = total_price;
        [self setItems:orderItems];
    }
    return self;
}

-(void)setItems:(NSArray *)items
{
    if (_items.count == 0) {
        _items = items;
        return;
    }
    
    NSMutableArray* itemMutable = [[NSMutableArray alloc] initWithArray:_items];
    
    for (OrderItem* orderItem in itemMutable) {
        for (CartItem* cartItem in items) {
            if (orderItem.product.idProduct == cartItem.idProduct) {
                //не меняем продукт в заказе
            }
            else {
                //добавил в заказ
                //ищем продукт по id и добавляем Product в заказ
                //[itemMutable addObject:cartItem];
            }
        }
    }
    
    _items = itemMutable;
}

-(NSArray *)getItems
{
    return _items;
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
