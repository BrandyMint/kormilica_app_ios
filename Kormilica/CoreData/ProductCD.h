//
//  ProductCD.h
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ProductCD : NSManagedObject

@property (nonatomic, retain) NSNumber * idCategory;
@property (nonatomic, retain) NSNumber * idProduct;
@property (nonatomic, retain) NSString * mobile_url;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSNumber * price_cents;
@property (nonatomic, retain) NSString * price_currency;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * updated_at;

@end
