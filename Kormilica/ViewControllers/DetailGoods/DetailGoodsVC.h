//
//  DetailGoodsVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterVC.h"
#import "BuyView.h"
#import "TTTAttributedLabel.h"

@interface DetailGoodsVC : MasterVC

//public
@property (nonatomic, assign) NSInteger idProduct;
@property (nonatomic, assign) BOOL isBigStyle;

@property (weak, nonatomic) IBOutlet BuyView *onBuy;

@end
