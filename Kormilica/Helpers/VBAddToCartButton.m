//
//  VBAddToCartButton.m
//  Kormilica
//
//  Created by bespalown on 20/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "VBAddToCartButton.h"
#import "NSString+Currency.h"

@implementation VBAddToCartButton
{
    NSString *currency;
    NSNumber *amount;
    
    UIImageView *noCartPlusImageView;
    UILabel *noCartAmountLabel;
    
    UIView *inOrderBackground;
    UILabel *leftOrderLabel;
    UILabel *rightOrderLabel;
    
    UIFont *font;
}

-(void)setAmount:(NSNumber *)theAmount currency:(NSString *)theCurrency;
{
    amount = theAmount;
    currency = theCurrency;
    font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    
    [self initDefault];
}

-(void)initDefault
{
    [self setTitleColor:[[VBStyle style] amountProductColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:font];
    
    //состояние кнопки когда товар "не в корзине"
    noCartPlusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 12, 12)];
    [noCartPlusImageView setImage:[UIImage imageNamed:@"plus_"]];
    
    noCartAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 60, 40)];
    noCartAmountLabel.textAlignment = NSTextAlignmentCenter;
    noCartAmountLabel.textColor = [[VBStyle style] amountProductColor];
    noCartAmountLabel.attributedText = [[NSAttributedString alloc] initWithAttributedString: [[NSString stringWithFormat:@"%ld",[amount longValue]]
                                                                                        fromCurrencyCents:currency
                                                                                        font:font]];
    [self addSubview:noCartAmountLabel];
    
    //состояние кнопки когда товар "в корзине"
    inOrderBackground = [[UIView alloc] initWithFrame:self.bounds];
    UIView *leftOrderBackground = [[UIView alloc] initWithFrame:
                                   CGRectMake(0, 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds))];
    leftOrderBackground.backgroundColor = [UIColor colorWithWhite:0.404 alpha:1.000];
    leftOrderLabel = [[UILabel alloc] initWithFrame:leftOrderBackground.bounds];
    leftOrderLabel.textColor = [UIColor whiteColor];
    leftOrderLabel.textAlignment = NSTextAlignmentCenter;
    leftOrderLabel.backgroundColor = [UIColor clearColor];
    leftOrderLabel.font = font;
    [leftOrderBackground addSubview:leftOrderLabel];
    [inOrderBackground addSubview:leftOrderBackground];
    
    UIView *rightOrderBackground = [[UIView alloc] initWithFrame:
                                    CGRectMake(CGRectGetMaxX(leftOrderBackground.frame), 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds))];
    rightOrderBackground.backgroundColor = [[VBStyle style] bottomBarAcceptColor];
    rightOrderLabel = [[UILabel alloc] initWithFrame:rightOrderBackground.bounds];
    rightOrderLabel.textColor = [UIColor whiteColor];
    rightOrderLabel.backgroundColor = [UIColor clearColor];
    rightOrderLabel.textAlignment = NSTextAlignmentCenter;
    rightOrderLabel.font = font;
    [rightOrderBackground addSubview:rightOrderLabel];
    inOrderBackground.userInteractionEnabled = rightOrderBackground.userInteractionEnabled = leftOrderBackground.userInteractionEnabled = leftOrderLabel.userInteractionEnabled = rightOrderLabel.userInteractionEnabled;
    [inOrderBackground addSubview:rightOrderBackground];
    
    [self goodNotCart];
    //[self goodsCountInCart:@1];
}

-(void)goodNotCart;
{
    [inOrderBackground removeFromSuperview];
    [self addSubview:noCartPlusImageView];
    [self addSubview:noCartAmountLabel];
    
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[VBStyle style] amountProductColor].CGColor;
    [self setTitle:@"Добавить в заказ" forState:UIControlStateNormal];
    [self addSubview:noCartPlusImageView];
}

-(void)goodsCountInCart:(NSNumber *)theGoodsCount;
{
    [noCartAmountLabel removeFromSuperview];
    [noCartPlusImageView removeFromSuperview];
    [self addSubview:inOrderBackground];
    
    self.layer.cornerRadius = 0;
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    [self setTitle:nil forState:UIControlStateNormal];
    
    //1 шт. // 100 Р
    
    NSNumber *sum = [NSNumber numberWithDouble:([amount doubleValue] * [theGoodsCount doubleValue])];
    
    leftOrderLabel.textColor = rightOrderLabel.textColor = [UIColor whiteColor];
    leftOrderLabel.text = [NSString stringWithFormat:@"%ld шт.",[theGoodsCount longValue]];
    rightOrderLabel.attributedText = [[NSAttributedString alloc] initWithAttributedString: [[NSString stringWithFormat:@"%ld",[sum longValue]]
                                                                                            fromCurrencyCents:currency
                                                                                            font:font]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
