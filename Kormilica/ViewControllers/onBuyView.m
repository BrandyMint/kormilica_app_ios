//
//  onBuyView.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "onBuyView.h"

@implementation onBuyView

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
    self.userInteractionEnabled = allowed;
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    view.userInteractionEnabled = YES;
    [self addSubview:view];
    if (allowed) {
        view.backgroundColor = COLOR_BLUE_;
        UILabel* deliveryPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                                0,
                                                                                100,
                                                                                CGRectGetHeight(view.frame))];
        deliveryPriceLabel.font = [UIFont systemFontOfSize:14];
        deliveryPriceLabel.textColor = [UIColor whiteColor];
        deliveryPriceLabel.textAlignment = NSTextAlignmentCenter;
        deliveryPriceLabel.contentMode = UIViewContentModeCenter;
        deliveryPriceLabel.backgroundColor = [UIColor clearColor];
        deliveryPriceLabel.numberOfLines = 2;
        [view addSubview: deliveryPriceLabel];
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(deliveryPriceLabel.frame), 0, 1, CGRectGetHeight(view.frame))];
        line.backgroundColor = COLOR_GRAY;
        [view addSubview:line];
        
        UILabel* checkoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame),
                                                                           0,
                                                                           CGRectGetWidth(view.frame) - CGRectGetMinX(line.frame),
                                                                           CGRectGetHeight(view.frame))];
        checkoutLabel.font = [UIFont systemFontOfSize:16];
        checkoutLabel.textColor = [UIColor whiteColor];
        checkoutLabel.textAlignment = NSTextAlignmentCenter;
        checkoutLabel.contentMode = UIViewContentModeCenter;
        checkoutLabel.backgroundColor = [UIColor clearColor];
        checkoutLabel.numberOfLines = 1;
        [view addSubview: checkoutLabel];
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        deliveryPriceLabel.text = [NSString stringWithFormat:@"Итого \n %d %@",appDelegate.bundles.vendor.delivery_price.cents, appDelegate.bundles.vendor.delivery_price.currency];
        checkoutLabel.text = @"Оформить заказ";
    }
    else {
        view.backgroundColor = COLOR_GRAY;
        
        UILabel* buttomSelectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               CGRectGetWidth(view.frame),
                                                                               CGRectGetHeight(view.frame)/2)];
        buttomSelectLabel.font = [UIFont systemFontOfSize:14];
        buttomSelectLabel.textColor = [UIColor blackColor];
        buttomSelectLabel.textAlignment = NSTextAlignmentCenter;
        buttomSelectLabel.contentMode = UIViewContentModeCenter;
        buttomSelectLabel.backgroundColor = [UIColor clearColor];
        [view addSubview: buttomSelectLabel];
        
        UILabel* buttomDeliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                                 CGRectGetHeight(view.frame)/2,
                                                                                 CGRectGetWidth(view.frame),
                                                                                 CGRectGetHeight(view.frame)/2)];
        buttomDeliveryLabel.font = [UIFont systemFontOfSize:14];
        buttomDeliveryLabel.textColor = COLOR_ORANGE;
        buttomDeliveryLabel.textAlignment = NSTextAlignmentCenter;
        buttomDeliveryLabel.contentMode = UIViewContentModeCenter;
        buttomDeliveryLabel.backgroundColor = [UIColor clearColor];
        [view addSubview: buttomDeliveryLabel];
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        buttomSelectLabel.text = appDelegate.bundles.vendor.mobile_footer;
        buttomDeliveryLabel.text = appDelegate.bundles.vendor.mobile_delivery;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate onBuyAction];
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
