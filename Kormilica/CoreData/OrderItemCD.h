//
//  OrderItemCD.h
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProductCD;

@interface OrderItemCD : NSManagedObject

@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) ProductCD *product;

@end
