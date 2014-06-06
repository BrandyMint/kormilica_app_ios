//
//  ConvertTime.h
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertTime : NSObject

-(NSString *)iso8601_to_ddMMYYYY:(NSString*)iso8601;

@end
