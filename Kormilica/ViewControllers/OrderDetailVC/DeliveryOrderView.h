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
-(void)onDeliveryOrderSending;
-(void)onDeliveryOrderFailSending;
-(void)onDeliveryOrderAction;
-(void)onDeliveryOrderBackToShop;
@end

#import <UIKit/UIKit.h>

@interface DeliveryOrderView : UIView
@property (assign) id<DeliveryOrderDelegate> delegate;

-(void)view:(typeView)view;

@end
