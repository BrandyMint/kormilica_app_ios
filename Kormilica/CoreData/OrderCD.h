//
//  OrderCD.h
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderItemCD;

@interface OrderCD : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSNumber * total_price_cents;
@property (nonatomic, retain) NSString * total_price_currency;
@property (nonatomic, retain) NSSet *items;
@end

@interface OrderCD (CoreDataGeneratedAccessors)

- (void)addItemsObject:(OrderItemCD *)value;
- (void)removeItemsObject:(OrderItemCD *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
