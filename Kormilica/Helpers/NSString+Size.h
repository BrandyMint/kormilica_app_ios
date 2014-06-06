//
//  NSString+Size.h
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

-(CGSize)sizeText:(NSString*)text width:(CGFloat)width font:(UIFont*)font;

@end
