//
//  ConvertTime.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "ConvertTime.h"
#import "ISO8601DateFormatter.h"

@implementation ConvertTime

-(NSString *)iso8601_to_ddMMYYYY:(NSString*)iso8601
{
    ISO8601DateFormatter * date_formatter1 = [[ISO8601DateFormatter alloc] init];
    NSDate * result1 = [date_formatter1 dateFromString: iso8601];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy"];
    NSString *string = [format stringFromDate:result1];

    return string;
}

@end
