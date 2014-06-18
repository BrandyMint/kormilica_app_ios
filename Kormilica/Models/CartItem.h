//
//  CartItem.h
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartItem : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger idProduct;

//-(Product *)product;

-(id)initWithIdProduct:(NSInteger )idProduct count:(NSInteger )count;

@end
