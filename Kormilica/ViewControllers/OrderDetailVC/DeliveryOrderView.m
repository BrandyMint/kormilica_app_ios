//
//  DeliveryOrderView.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "DeliveryOrderView.h"

@implementation DeliveryOrderView
{
    UIActivityIndicatorView *activityIndicator;
    UILabel* label;
    BOOL isDeliverACtion;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        activityIndicator.center = CGPointMake(60, CGRectGetHeight(self.frame)/2);
        [self addSubview: activityIndicator];
    }
    return self;
}

-(void)view:(typeView)view
{
    self.userInteractionEnabled = NO;
    
    switch (view) {
        case fill:
            //fill
            label.text = @"Впишите телефон и адрес для доставки";
            label.textColor = [UIColor blackColor];
            label.backgroundColor = COLOR_GRAY;
            break;
        case deliver:
            //deliver
            label.text = @"Доставить заказ";
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = COLOR_GREEN_;
            isDeliverACtion = YES;
            self.userInteractionEnabled = YES;
            break;
        case sending:
            label.text = @"Отправляем заказ";
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor whiteColor];
            [activityIndicator startAnimating];
            [self performSelector:@selector(orderSending) withObject:nil afterDelay:2];
            break;
        case backToShop:
            isDeliverACtion = NO;
            self.userInteractionEnabled = YES;
            label.text = @"Вернуться в магазин";
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = COLOR_BLUE_;
            break;
        default:
            break;
    }
}

-(void)orderSending
{
    [activityIndicator stopAnimating];
    
    [_delegate onDeliveryOrderSending];

    //[_delegate onDeliveryOrderFailSending];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isDeliverACtion) {
        [_delegate onDeliveryOrderAction];
    }
    else {
        [_delegate onDeliveryOrderBackToShop];
    }
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
