//
//  VBStyle.h
//  Kormilica
//
//  Created by bespalown on 14/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+Overlay.h"

@interface VBStyle : NSObject

+(id)style;
-(void)initStyle:(NSString *)theStyle;

//корзина
-(UIColor *)cartNumberRowColor;
-(UIColor *)cartTitleColor;
-(UIFont *)cartTitleFont;
-(UIColor *)cartCountViewBacgroundColor;
-(UIColor *)cartSumViewBackgroundColor;
-(UIFont *)cartSumViewBackgroundFont;
-(UIColor *)cartItogoBackGroundColor;
-(UIFont *)cartItogoFont;
-(UIColor *)cartItogoColor;

//подробное описание


//
-(UIColor *)bottomBarAcceptColor;
-(UIColor *)bottomBarNotAcceptColor;

//
-(UIColor *)inOrderStateCountColor;
-(UIFont *)inOrderStateCountFont;
-(UIImage *)inOrderStateImage;
-(UIImage *)notInOrderStateImage;

//таблица
-(UIColor *)nameProductColor;
-(UIFont *)nameProductFont;
-(UIColor *)amountProductColor;
-(UIFont *)amountProductFont;

-(UIColor *)navigationBarFontColor;
-(UIFont *)navigationBarFont;
-(UIColor *)navigationBarColor;

-(UIFont *)menuFont;
-(UIColor *)menuBackground;

@end
