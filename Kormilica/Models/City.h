//
//  City.h
//  Kormilica
//
//  Created by Viktor Bespalov on 11/08/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString* created_at;
@property (nonatomic, assign) NSUInteger idCity;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* updated_at;

@end

/*
 city =         {
 "created_at" = "2014-07-24T11:17:13.756+04:00";
 id = 1;
 latitude = "56.1322";
 longitude = "47.2519";
 name = "\U0427\U0435\U0431\U043e\U043a\U0441\U0430\U0440\U044b";
 "updated_at" = "2014-08-04T14:33:08.856+04:00";
 };

*/