//
//  onBuyView.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "BuyView.h"
#import "UIView+NUI.h"
#import "UILabel+NUI.h"
#import "NSString+Currency.h"

@implementation BuyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)isAllowed:(BOOL)allowed
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self addSubview:view];
    [NUIRenderer renderView:view withClass:allowed ? @"OrderAllowed" : @"OrderNotAllowed"];
    
    UILabel* deliveryPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            100,
                                                                            CGRectGetHeight(view.frame))];
    deliveryPriceLabel.textColor = [UIColor whiteColor];
    deliveryPriceLabel.textAlignment = NSTextAlignmentCenter;
    deliveryPriceLabel.contentMode = UIViewContentModeCenter;
    deliveryPriceLabel.backgroundColor = [UIColor clearColor];
    deliveryPriceLabel.numberOfLines = 2;
    //[deliveryPriceLabel setNuiClass:@"Label:WhiteText"];
    [view addSubview: deliveryPriceLabel];
    
    UIView* verticalLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(deliveryPriceLabel.frame), 0, 1, CGRectGetHeight(view.frame))];
    //verticalLine.backgroundColor = [UIColor blackColor];
    //[NUIRenderer renderView:verticalLine withClass:!allowed ? @"OrderAllowed" : @"OrderNotAllowed"];
    //[view addSubview:verticalLine];
    
    //UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
    //topLine.backgroundColor = [UIColor blackColor];
    //[NUIRenderer renderView:topLine withClass:!allowed ? @"OrderAllowed" : @"OrderNotAllowed"];
    //[view addSubview:topLine];
    
    UILabel* checkoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(verticalLine.frame),
                                                                       0,
                                                                       CGRectGetWidth(view.frame) - CGRectGetMinX(verticalLine.frame),
                                                                       CGRectGetHeight(view.frame))];
    checkoutLabel.textColor = [UIColor whiteColor];
    checkoutLabel.textAlignment = NSTextAlignmentCenter;
    checkoutLabel.contentMode = UIViewContentModeCenter;
    checkoutLabel.backgroundColor = [UIColor clearColor];
    checkoutLabel.numberOfLines = 1;
    //[checkoutLabel setNuiClass:@"Label:WhiteText"];
    checkoutLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [view addSubview: checkoutLabel];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    Money* totalPrice = [appDelegate.cart getTotalPriceFromProducts:appDelegate.bundles.products];
    //deliveryPriceLabel.text = [NSString stringWithFormat:@"Итого \n %d %@", totalPrice.cents, totalPrice.currency];
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:@"Итого:\n"];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:14] range:NSMakeRange(0, attrString.length)];
    [attrString appendAttributedString:[[NSString stringWithFormat:@"%ld",(long)totalPrice.cents] fromCurrency:totalPrice.currency font:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]]];
    deliveryPriceLabel.attributedText = attrString;

    checkoutLabel.text = @"Оформить заказ";
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isUserInEnabled) {
        [_delegate onBuyAction];
    }
    else {
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Внимание"
                                                        message:[NSString stringWithFormat:@"Минимальная сумма заказа составляет %ld Р", appDelegate.bundles.vendor.minimal_price.cents/100]
                                                       delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

}

-(void)setUserInteractionEnabled:(BOOL)enabled
{
    isUserInEnabled = enabled;
    //self.superview.userInteractionEnabled = enabled;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
