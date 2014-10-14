//
//  VBStyle.m
//  Kormilica
//
//  Created by bespalown on 14/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "VBStyle.h"

@implementation VBStyle
{
    UIColor *_menuBackgroundColor;
    UIFont *_menuFont;

    UIColor *_navigationBarColor;
    UIFont *_navigationBarFont;
    UIColor *_navigationBarFontColor;
}

+(id)sharedInstance;{
    static VBStyle *style = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        style = [[self alloc] init];
    });
    return style;
}

-(void)initStyle:(NSString *)theStyle;
{
    if  (theStyle.length == 0 || !theStyle) {
        theStyle = @"orange";
    }
    if ([theStyle isEqualToString:@"orange"]) {
        _menuBackgroundColor = [UIColor colorWithRed:0.302 green:0.337 blue:0.353 alpha:1.000];
        _menuFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        _navigationBarColor = [UIColor colorWithRed:0.941 green:0.475 blue:0.349 alpha:1.000];
        _navigationBarFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
        _navigationBarFontColor = [UIColor whiteColor];
    }
    else if ([theStyle isEqualToString:@"blue"]) {
        _menuBackgroundColor = [UIColor colorWithWhite:0.169 alpha:1.000];

    }
}

-(UIColor *)navigationBarFontColor {
    return _navigationBarFontColor;
}

-(UIFont *)navigationBarFont {
    return _navigationBarFont;
}

-(UIColor *)navigationBarColor {
    return _navigationBarColor;
}

-(UIFont *)menuFont {
    return _menuFont;
}

- (UIColor *)menuBackground {
    return _menuBackgroundColor;
}

@end
