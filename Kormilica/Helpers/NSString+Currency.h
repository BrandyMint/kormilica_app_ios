//
//  NSAttributedString+rub.h
//  Kormilica
//
//  Created by Viktor Bespalov on 14/08/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (currency)

-(NSMutableAttributedString *)fromCurrencyCents:(NSString *)currency font:(UIFont *)theFont;
-(NSMutableAttributedString *)fromCurrencyCents:(NSString *)currency;
-(NSMutableAttributedString *)fromCurrency:(NSString *)currency font:(UIFont *)theFont;
-(NSMutableAttributedString *)fromCurrency:(NSString *)currency;

@end
