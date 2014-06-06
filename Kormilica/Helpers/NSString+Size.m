//
//  NSString+Size.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

-(CGSize)sizeText:(NSString*)text width:(CGFloat)width font:(UIFont*)font
{
    CGSize boundingSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize requiredSize = [text sizeWithFont:font
                           constrainedToSize:boundingSize
                               lineBreakMode:NSLineBreakByCharWrapping];
    return requiredSize;
}

@end
