//
//  Product.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Price.h"
#import "Image.h"

@interface Product : NSObject

//my
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger idProduct;
@property (nonatomic, assign) NSInteger idCategory;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* updated_at;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, strong) Price* price;
@property (nonatomic, strong) Image* image;

@end

/*
"id": 8,
"category_id": 1,
"title": "Вкусняшка 1",
"updated_at": "2014-03-28T12:49:59.072+04:00",
"position": 10,
"price": {
    "cents": 1000,
    "currency": "RUB"
},
"image": {
    "mobile_url": "http://aydamarket.ru/uploads/product/image/8/mobile_8.png"
}
*/