//
//  onBuyView.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyView;
@protocol onBuyViewDelegate
@optional
-(void)onBuyAction;

@end

@interface BuyView : UIView
{
    BOOL isUserInEnabled;
}

//public
-(void)isAllowed:(BOOL)allowed;
-(void)setUserInteractionEnabled:(BOOL)enabled;

@property (assign) id<onBuyViewDelegate> delegate;
@end
