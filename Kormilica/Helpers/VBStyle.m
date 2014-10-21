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
    
    //cell
    UIColor *_nameProductColor;
    UIFont *_nameProductFont;
    UIColor *_amountProductColor;
    UIFont *_amountProductFont;
    
    //
    UIImage *_inOrderStateImage;
    UIImage *_notInOrderStateImage;
    UIColor *_inOrderStateCountColor;
    UIFont *_inOrderStateCountFont;
    
    UIColor *_bottomBarAcceptColor;
    UIColor *_bottomBarNotAcceptColor;
    
    //cart
    UIColor *_cartNumberRowColor;
    UIColor *_cartTitleColor;
    UIColor *_cartCountViewBacgroundColor;
    UIColor *_cartSumViewBackgroundColor;
    UIFont *_cartTitleFont;
    UIFont *_cartSumViewBackgroundFont;
    UIFont *_cartItogoFont;
    UIColor *_cartItogoBackGroundColor;
    UIColor *_cartItogoColor;
    
}

+(id)style;{
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
        _menuFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        _navigationBarColor = [UIColor colorWithRed:0.941 green:0.475 blue:0.349 alpha:1.000];
        _navigationBarFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
        _navigationBarFontColor = [UIColor whiteColor];
        _nameProductColor = [UIColor colorWithWhite:0.165 alpha:1.000];
        _nameProductFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
        _amountProductColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000];
        _amountProductFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
        _bottomBarAcceptColor = [UIColor colorWithRed:0.388 green:0.686 blue:0.188 alpha:1.000];
        _bottomBarNotAcceptColor = [UIColor colorWithRed:1.000 green:0.902 blue:0.553 alpha:1.000];
        _inOrderStateImage = [[UIImage imageNamed:@"circle"] imageWithColor:_bottomBarAcceptColor];
        _notInOrderStateImage = [[UIImage imageNamed:@"plus"] imageWithColor:_amountProductColor];
        _inOrderStateCountColor = [UIColor whiteColor];
        _inOrderStateCountFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        
        _cartNumberRowColor = [UIColor colorWithRed:0.941 green:0.475 blue:0.349 alpha:1.000];
        _cartTitleColor = [UIColor colorWithWhite:0.123 alpha:1.000];
        _cartCountViewBacgroundColor = [UIColor colorWithWhite:0.330 alpha:1.000];
        _cartSumViewBackgroundColor = _bottomBarAcceptColor;
        _cartTitleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
        _cartSumViewBackgroundFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.5];
        _cartItogoColor = [UIColor colorWithWhite:0.202 alpha:1.000];
        _cartItogoFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        _cartItogoBackGroundColor = [UIColor colorWithWhite:0.951 alpha:1.000];
    }
    else if ([theStyle isEqualToString:@"blue"]) {
        _menuBackgroundColor = [UIColor colorWithWhite:0.169 alpha:1.000];
    }
}

-(UIColor *)cartNumberRowColor          { return _cartNumberRowColor; }
-(UIColor *)cartTitleColor              { return _cartTitleColor; }
-(UIFont *)cartTitleFont                { return _cartTitleFont; }
-(UIColor *)cartCountViewBacgroundColor { return _cartCountViewBacgroundColor; }
-(UIColor *)cartSumViewBackgroundColor  { return _cartSumViewBackgroundColor; }
-(UIFont *)cartSumViewBackgroundFont    { return _cartSumViewBackgroundFont; }
-(UIColor *)cartItogoBackGroundColor    { return _cartItogoBackGroundColor; }
-(UIFont *)cartItogoFont                { return _cartItogoFont; }
-(UIColor *)cartItogoColor              { return _cartItogoColor; }

-(UIColor *)bottomBarAcceptColor    { return _bottomBarAcceptColor;     }
-(UIColor *)bottomBarNotAcceptColor { return _bottomBarNotAcceptColor;  }

-(UIColor *)inOrderStateCountColor  { return _inOrderStateCountColor;   }
-(UIFont *)inOrderStateCountFont    { return _inOrderStateCountFont;    }
-(UIImage *)inOrderStateImage       { return _inOrderStateImage;        }
-(UIImage *)notInOrderStateImage    { return _notInOrderStateImage;     }

-(UIColor *)nameProductColor {  return _nameProductColor;    }
-(UIFont *)nameProductFont {    return _nameProductFont;    }
-(UIColor *)amountProductColor {  return _amountProductColor;    }
-(UIFont *)amountProductFont {    return _amountProductFont;    }

-(UIColor *)navigationBarFontColor {    return _navigationBarFontColor; }
-(UIFont *)navigationBarFont {     return _navigationBarFont;  }
-(UIColor *)navigationBarColor {    return _navigationBarColor; }

-(UIFont *)menuFont {    return _menuFont;   }
-(UIColor *)menuBackground {    return _menuBackgroundColor;    }

@end
