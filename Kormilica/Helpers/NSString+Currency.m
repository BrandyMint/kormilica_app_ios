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
    return [self fromCurrencyCents:currency font:nil];
}

-(NSMutableAttributedString *)fromCurrencyCents:(NSString *)currency font:(UIFont *)theFont
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    if (theFont) {
        font = theFont;
    }
    
    CGFloat cents = [self integerValue]/100;
    NSMutableAttributedString *amountAttr = [[NSMutableAttributedString alloc] initWithString:[self getFormattedAmount:[NSNumber numberWithFloat:cents]]];
    [amountAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, amountAttr.length)];
    
    NSMutableAttributedString *currencyAttr = [[NSMutableAttributedString alloc] init];
    
    if ([currency isEqualToString:@"RUB"]) {
        [currencyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"B"]];
        [currencyAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"W1Rouble-Regular" size:font.pointSize] range:NSMakeRange(0, currencyAttr.length)];
    }
    else if ([currency isEqualToString:@"USD"])
    {
        [currencyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"$"]];
    }
    
    [amountAttr appendAttributedString:currencyAttr];
    
    return amountAttr;
}

-(NSMutableAttributedString *)fromCurrency:(NSString *)currency
{
    return [self fromCurrency:currency font:nil];
}

-(NSMutableAttributedString *)fromCurrency:(NSString *)currency font:(UIFont *)theFont
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    if (theFont) {
        font = theFont;
    }
    
    CGFloat cents = [self integerValue];
    NSMutableAttributedString *amountAttr = [[NSMutableAttributedString alloc] initWithString:[self getFormattedAmount:[NSNumber numberWithFloat:cents]]];
    [amountAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, amountAttr.length)];
    
    NSMutableAttributedString *currencyAttr = [[NSMutableAttributedString alloc] init];
    
    if ([currency isEqualToString:@"RUB"]) {
        [currencyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"B"]];
        [currencyAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"W1Rouble-Regular" size:font.pointSize] range:NSMakeRange(0, currencyAttr.length)];
    }
    else if ([currency isEqualToString:@"USD"])
    {
        [currencyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"$"]];
    }
    
    [amountAttr appendAttributedString:currencyAttr];
    
    return amountAttr;
}

-(NSString *)getFormattedAmount:(NSNumber *)theAmount
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingIncrement: [NSNumber numberWithDouble:1]];
    
    NSLocale *ruLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    [formatter setLocale:ruLocale];
    
    NSString *result = [formatter stringFromNumber:theAmount];
    return [result stringByAppendingString:@" "];
}

@end