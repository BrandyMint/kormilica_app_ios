//
//  AccessoriesOrderView.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AccessoriesOrderView.h"

@implementation AccessoriesOrderView
{
    UIActivityIndicatorView *activityIndicator;
    UILabel* label;
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
            self.userInteractionEnabled = YES;
            break;
        case sending:
            label.text = @"Отправляем заказ";
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor whiteColor];
            [activityIndicator startAnimating];
            [self performSelector:@selector(orderSending) withObject:nil afterDelay:5];
            break;
        default:
            break;
    }
}

-(void)orderSending
{
    [activityIndicator stopAnimating];
    [_delegate onAccessoriesOrderSending];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate onAccessoriesOrderAction];
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
