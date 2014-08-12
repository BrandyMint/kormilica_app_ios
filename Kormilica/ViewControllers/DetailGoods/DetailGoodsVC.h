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

@property (weak, nonatomic) IBOutlet BuyView *onBuy;

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titleProduct;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *price;
@property (weak, nonatomic) IBOutlet UITextView *descriptions;
@property (weak, nonatomic) IBOutlet UIButton *onOrder;
- (IBAction)onOrder:(id)sender;

@end
