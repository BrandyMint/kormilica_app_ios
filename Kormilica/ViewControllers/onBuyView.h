//
//  onBuyView.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class onBuyView;
@protocol onBuyViewDelegate
@optional
-(void)onBuyAction;

@end

@interface onBuyView : UIView
//public
-(void)isAllowed:(BOOL)allowed;

@property (assign) id<onBuyViewDelegate> delegate;
@end
