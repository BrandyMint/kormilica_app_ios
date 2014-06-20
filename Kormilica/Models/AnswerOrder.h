//
//  AnswerOrder.h
//  Kormilica
//
//  Created by Viktor Bespalov on 20/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.h"
#import "Message.h"

@interface AnswerOrder : NSObject

@property (nonatomic, assign) NSInteger idOrder;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, assign) NSInteger items_count;
@property (nonatomic, strong) Money* total_price;
@property (nonatomic, strong) Message* message;

@end

/*
 {
    "id": 369,
    "phone": "+79999999999",
    "items_count": 3,
    "total_price": {
        "cents": 99900,
        "currency": "RUB"
    },
    "message": {
        "subject": "Принят заказ №369",
        "text": "С вами свяжутся в течении нескольких минут"
    }
 }
*/