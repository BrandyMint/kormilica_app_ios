//
//  AnswerOrderFactory.m
//  Kormilica
//
//  Created by Viktor Bespalov on 20/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AnswerOrderFactory.h"
#import "Factory.h"

@implementation AnswerOrderFactory

+ (EKObjectMapping*) answerOrderMapping;
{
    return [EKObjectMapping mappingForClass:[AnswerOrder class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"phone",
                                      @"items_count"]];
        [mapping mapFieldsFromDictionary:@{@"id" : @"idOrder"}];
        [mapping hasOneMapping:[Factory priceMapping] forKey:@"total_price"];
        [mapping hasOneMapping:[self messageMapping] forKey:@"message"];
    }];
}

+ (EKObjectMapping*) messageMapping;
{
    return [EKObjectMapping mappingForClass:[Message class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"subject",
                                      @"text"]];
    }];
}

@end
