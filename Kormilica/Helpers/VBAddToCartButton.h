//
//  VBAddToCartButton.h
//  Kormilica
//
//  Created by bespalown on 20/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBAddToCartButton : UIButton

-(void)setAmount:(NSNumber *)theAmount currency:(NSString *)theCurrency;

-(void)goodNotCart;
-(void)goodsCountInCart:(NSNumber *)theGoodsCount;

@end
