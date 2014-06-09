//
//  AccessoriesOrderView.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

typedef enum
{
    fill,
    deliver,
    sending
}typeView;

@class AccessoriesOrder;
@protocol AccessoriesOrderDelegate
@optional
-(void)onAccessoriesOrderSending;
-(void)onAccessoriesOrderFailSending;
-(void)onAccessoriesOrderAction;
@end

#import <UIKit/UIKit.h>

@interface AccessoriesOrderView : UIView
@property (assign) id<AccessoriesOrderDelegate> delegate;

-(void)view:(typeView)view;

@end
