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
    BOOL isDeliverAction;
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
            isDeliverAction = YES;
            self.userInteractionEnabled = YES;
            break;
        case sending:
            label.text = @"Отправляем заказ";
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor whiteColor];
            [activityIndicator startAnimating];
            break;
        case backToShop:
            isDeliverAction = NO;
            self.userInteractionEnabled = YES;
            label.text = @"Вернуться в магазин";
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = COLOR_BLUE_;
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isDeliverAction) {
        //отправляемм заказ
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate.managers postOrder:_order block:^(AnswerOrder* answerOrder){
            
            [activityIndicator stopAnimating];
            [_delegate onDeliveryOrderSending:answerOrder];
        }failBlock:^(NSException* exception) {
            
            [activityIndicator stopAnimating];
            [_delegate onDeliveryOrderFailSending:exception];
        }];
        
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
