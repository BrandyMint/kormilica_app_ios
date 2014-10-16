//
//  VBStatusCardButton.h
//  Kormilica
//
//  Created by bespalown on 17/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBStatusCartButton : UIButton
@property (nonatomic, strong) UIColor *color;

-(void)setCountProductInCard:(NSUInteger)theCount;

@end
