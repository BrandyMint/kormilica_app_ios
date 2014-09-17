//
//  NSAttributedString+rub.m
//  Kormilica
//
//  Created by Viktor Bespalov on 14/08/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "NSString+Currency.h"

@implementation NSString (currency)

-(NSMutableAttributedString *)fromCurrencyCents:(NSString *)currency
{
    NSUInteger cents = 0;
    NSString* resultString = @"";
    NSString* resultString2 = @"";
    
    if ([currency isEqualToString:@"RUB"]) {
        cents = [self integerValue]/100;
        resultString = [NSString stringWithFormat:@"%d ",cents];
        resultString2 = [NSString stringWithFormat:@"%c",'C'];
        
    }
    else if ([currency isEqualToString:@"USD"])
    {
        cents = [self integerValue]/100;
        resultString = [NSString stringWithFormat:@"%d $",cents];
    }
    
    NSDictionary *attDict = @{NSFontAttributeName: [UIFont fontWithName: @"W1Rouble-Regular" size:14.0]};
    NSMutableAttributedString *attString2 = [[NSMutableAttributedString alloc] initWithString: resultString2 attributes: attDict];
   
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString: resultString];
    [attributeString appendAttributedString: attString2];
    return attributeString;
}

-(NSMutableAttributedString *)fromCurrency:(NSString *)currency
{
    /*
     NSUInteger cents = 0;
     NSString* resultString = @"";
     NSRange range = NSMakeRange(0, 0);
     
     if ([currency isEqualToString:@"RUB"]) {
     cents = [self integerValue];
     resultString = [NSString stringWithFormat:@"%d Р",cents];
     range = NSMakeRange(resultString.length - 1, 1);
     }
     else if ([currency isEqualToString:@"USD"])
     {
     cents = [self integerValue];
     resultString = [NSString stringWithFormat:@"%d $",cents];
     }
     
     NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:resultString];
     [attributeString addAttribute:NSStrikethroughStyleAttributeName
     value:@9
     range:range];
     return attributeString;
     */
    NSUInteger cents = 0;
    NSString* resultString = @"";
    NSString* resultString2 = @"";
    
    if ([currency isEqualToString:@"RUB"]) {
        cents = [self integerValue];
        resultString = [NSString stringWithFormat:@"%d ",cents];
        resultString2 = [NSString stringWithFormat:@"%c",'C'];
        
    }
    else if ([currency isEqualToString:@"USD"])
    {
        cents = [self integerValue];
        resultString = [NSString stringWithFormat:@"%d $",cents];
    }
    
    NSDictionary *attDict = @{NSFontAttributeName: [UIFont fontWithName: @"W1Rouble-Regular" size:17.0]};
    NSMutableAttributedString *attString2 = [[NSMutableAttributedString alloc] initWithString: resultString2 attributes: attDict];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString: resultString];
    [attributeString appendAttributedString: attString2];
    return attributeString;
}

@end