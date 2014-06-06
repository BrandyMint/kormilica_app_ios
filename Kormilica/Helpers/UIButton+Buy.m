//
//  UIButton+Buy.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "UIButton+Buy.h"

@implementation UIButton (Buy)

-(void)isAllowed:(BOOL)allowed
{
    self.enabled = allowed;
    if (allowed) {
        self.backgroundColor = COLOR_BLUE_;
        UILabel* deliveryPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               100,
                                                                               CGRectGetHeight(self.frame))];
        deliveryPriceLabel.font = [UIFont systemFontOfSize:14];
        deliveryPriceLabel.textColor = [UIColor whiteColor];
        deliveryPriceLabel.textAlignment = NSTextAlignmentCenter;
        deliveryPriceLabel.contentMode = UIViewContentModeCenter;
        deliveryPriceLabel.backgroundColor = [UIColor clearColor];
        deliveryPriceLabel.numberOfLines = 2;
        [self addSubview: deliveryPriceLabel];
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(deliveryPriceLabel.frame), 0, 1, CGRectGetHeight(self.frame))];
        view.backgroundColor = COLOR_GRAY;
        [self addSubview:view];
        
        UILabel* checkoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame),
                                                                                0,
                                                                                CGRectGetWidth(self.frame) - CGRectGetMinX(view.frame),
                                                                                CGRectGetHeight(self.frame))];
        checkoutLabel.font = [UIFont systemFontOfSize:16];
        checkoutLabel.textColor = [UIColor whiteColor];
        checkoutLabel.textAlignment = NSTextAlignmentCenter;
        checkoutLabel.contentMode = UIViewContentModeCenter;
        checkoutLabel.backgroundColor = [UIColor clearColor];
        checkoutLabel.numberOfLines = 1;
        [self addSubview: checkoutLabel];
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        deliveryPriceLabel.text = [NSString stringWithFormat:@"Итого \n %d %@",appDelegate.bundles.vendor.delivery_price.cents, appDelegate.bundles.vendor.delivery_price.currency];
        checkoutLabel.text = @"Оформить заказ";
    }
    else {
        self.backgroundColor = COLOR_GRAY;
        
        UILabel* buttomSelectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              CGRectGetWidth(self.frame),
                                                                              CGRectGetHeight(self.frame)/2)];
        buttomSelectLabel.font = [UIFont systemFontOfSize:14];
        buttomSelectLabel.textColor = [UIColor blackColor];
        buttomSelectLabel.textAlignment = NSTextAlignmentCenter;
        buttomSelectLabel.contentMode = UIViewContentModeCenter;
        buttomSelectLabel.backgroundColor = [UIColor clearColor];
        [self addSubview: buttomSelectLabel];
        
        UILabel* buttomDeliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                                CGRectGetHeight(self.frame)/2,
                                                                                CGRectGetWidth(self.frame),
                                                                                CGRectGetHeight(self.frame)/2)];
        buttomDeliveryLabel.font = [UIFont systemFontOfSize:14];
        buttomDeliveryLabel.textColor = COLOR_ORANGE;
        buttomDeliveryLabel.textAlignment = NSTextAlignmentCenter;
        buttomDeliveryLabel.contentMode = UIViewContentModeCenter;
        buttomDeliveryLabel.backgroundColor = [UIColor clearColor];
        [self addSubview: buttomDeliveryLabel];
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        buttomSelectLabel.text = appDelegate.bundles.vendor.mobile_footer;
        buttomDeliveryLabel.text = appDelegate.bundles.vendor.mobile_delivery;
    }
}

@end

