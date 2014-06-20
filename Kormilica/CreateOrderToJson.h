//
//  CreateListsToJson.h
//  FairPrice
//
//  Created by Viktor Bespalov on 25/02/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@interface CreateOrderToJson : NSObject

-(NSData *)getOrderDataWithOrder:(Order *)order;

@end
