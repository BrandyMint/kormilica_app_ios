//
//  CoreDataHelper.h
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import "OrderCD.h"

@interface CoreDataHelper : NSObject

-(void)saveOrder:(Order *)order;
-(OrderCD *)getOrder;
-(void)deleteOrder;

@end
