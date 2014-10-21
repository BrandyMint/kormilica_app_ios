//
//  CreateListsToJson.m
//  FairPrice
//
//  Created by Viktor Bespalov on 25/02/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "CreateOrderToJson.h"
#import "ProductCD.h"

@implementation CreateOrderToJson

-(NSData *)getOrderDataWithOrder:(Order *)order
{
    NSDictionary* user = [NSDictionary dictionaryWithObjectsAndKeys:
                                [self setObjectOrNull:[NSString stringWithFormat:@"%d",1]], @"id",
                                [self setObjectOrNull:order.address.address],               @"address",
                                [self setObjectOrNull:order.address.phone],                 @"phone",
                                [self setObjectOrNull:@"+7"], @"phone_prefix",
                                [self setObjectOrNull:@""], @"name",
                                //[self setObjectOrNull:@""], @"lastUpdateAt",
                                nil];
    
    NSDictionary* total_cost = [NSDictionary dictionaryWithObjectsAndKeys:
                                [self setObjectOrNull:[NSString stringWithFormat:@"%ld",order.total_price.cents*100]],   @"cents",
                                [self setObjectOrNull:order.total_price.currency],                                      @"currency",
                                nil];
    
    NSDictionary* delivery_price = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [self setObjectOrNull:[NSString stringWithFormat:@"%d",0]],   @"cents",
                                    [self setObjectOrNull:order.total_price.currency],            @"currency",
                                    nil];
    
    NSMutableArray* items = [NSMutableArray new];
    for (OrderItem* orderItem in order.items) {
        NSDictionary* itemsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [self setObjectOrNull:[NSString stringWithFormat:@"%ld",(long)orderItem.product.idProduct]],    @"product_id",
                                        [self setObjectOrNull:[NSString stringWithFormat:@"%ld",(long)orderItem.count]],                @"count",
                                        [self setObjectOrNull:[NSString stringWithFormat:@"%ld",(long)orderItem.product.price.cents]],  @"price",
                                        nil];
        [items addObject:itemsDictionary];
    }
    
    NSDictionary* orderDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [self setObjectOrNull:[NSString stringWithFormat:@"%lu",(unsigned long)items.count]],   @"total_count",
                                    [self setObjectOrNull:[NSString stringWithFormat:@"%ld",order.total_price.cents*100]],  @"total_cost_cents",
                                    [self setObjectOrNull:user],                                                            @"user",
                                    [self setObjectOrNull:total_cost],                                                      @"total_cost",
                                    [self setObjectOrNull:delivery_price],                                                  @"delivery_price",
                                    [self setObjectOrNull:user],                                                            @"user",
                                    [self setObjectOrNull:items],                                                           @"items",
                                    nil];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:orderDictionary options:NSJSONWritingPrettyPrinted error:nil];
    //NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"jsonData as string:\n%@", jsonString);
    
    return jsonData;
}

- (id)setObjectOrNull:(id)anObject
{
	if(anObject != nil) {
		return anObject;
	}
	else {
		return [NSNull null];
	}
}

@end
