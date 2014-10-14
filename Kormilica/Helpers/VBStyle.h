//
//  VBStyle.h
//  Kormilica
//
//  Created by bespalown on 14/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBStyle : NSObject

+(id)sharedInstance;
-(void)initStyle:(NSString *)theStyle;

-(UIColor *)navigationBarFontColor;
-(UIFont *)navigationBarFont;
-(UIColor *)navigationBarColor;
-(UIFont *)menuFont;
-(UIColor *)menuBackground;

@end
