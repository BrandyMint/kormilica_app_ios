//
//  Factory.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+ (EKObjectMapping*) bundlesMapping;
{
    return [EKObjectMapping mappingForClass:[Bundles class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"update"]];
        [mapping hasOneMapping:[self vendorMapping] forKey:@"vendor"];
        [mapping hasManyMapping:[self categoriesMapping] forKey:@"categories"];
        [mapping hasManyMapping:[self productMapping] forKey:@"products"];
    }];
}

+ (EKObjectMapping*) vendorMapping;
{
    return [EKObjectMapping mappingForClass:[Vendor class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"key",
                                      @"city",
                                      @"name",
                                      @"phone",
                                      @"updated_at",
                                      @"mobile_logo_url",
                                      @"mobile_title",
                                      @"mobile_subject",
                                      @"mobile_description",
                                      @"mobile_footer",
                                      @"mobile_delivery",
                                      @"mobile_empty_cart_alert",
                                      @"mobile_minimal_alert",
                                      @"currency",
                                      @"is_demo",
                                      ]];
        //[mapping hasOneMapping:[self cityMapping] forKey:@"city"];
        [mapping hasOneMapping:[self priceMapping] forKey:@"minimal_price"];
        [mapping hasOneMapping:[self priceMapping] forKey:@"delivery_price"];
    }];
}

+ (EKObjectMapping*) cityMapping;
{
    return [EKObjectMapping mappingForClass:[City class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"created_at",
                                      @"latitude",
                                      @"longitude",
                                      @"name",
                                      @"updated_at"]];
        [mapping mapFieldsFromDictionary:@{@"id" : @"idCity"}];
    }];
}

+ (EKObjectMapping*) priceMapping;
{
    return [EKObjectMapping mappingForClass:[Money class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"cents",
                                      @"currency"]];
    }];
}

+ (EKObjectMapping*) categoriesMapping;
{
    return [EKObjectMapping mappingForClass:[Categories class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"name",
                                      @"updated_at",
                                      @"position"]];
        [mapping mapFieldsFromDictionary:@{@"id" : @"idCategories"}];
    }];
}

+ (EKObjectMapping*) productMapping;
{
    return [EKObjectMapping mappingForClass:[Product class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"title",
                                      @"updated_at",
                                      @"position"]];
        [mapping mapFieldsFromDictionary:@{@"id" : @"idProduct",
                                           @"category_id" : @"idCategory"}];
        [mapping hasOneMapping:[self priceMapping] forKey:@"price"];
        [mapping hasOneMapping:[self imageMapping] forKey:@"image"];
    }];
}

+ (EKObjectMapping*) imageMapping;
{
    return [EKObjectMapping mappingForClass:[Image class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"mobile_url"]];
    }];
}

@end
