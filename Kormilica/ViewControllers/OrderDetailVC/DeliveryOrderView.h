//
//  DeliveryOrderView.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

typedef enum
{
    fill,
    deliver,
    sending,
    backToShop
}typeView;

@class DeliveryOrder;
@protocol DeliveryOrderDelegate
@optional
-(void)onDeliveryOrderSending:(AnswerOrder* ) answerOrder;
-(void)onDeliveryOrderFailSending:(NSException* )exception;
-(void)onDeliveryOrderAction;
-(void)onDeliveryOrderBackToShop;
@end

#import <UIKit/UIKit.h>
#import "Order.h"

@interface DeliveryOrderView : UIView
@property (assign) id<DeliveryOrderDelegate> delegate;
@property (nonatomic, strong) Order* order;

-(void)view:(typeView)view;

@end
