//
//  AboutDeliveryCell.m
//  Kormilica
//
//  Created by bespalown on 07/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutDeliveryCell.h"
#import "UIButton+NUI.h"

@implementation AboutDeliveryCell

-(void)layoutSubviews
{
    [NUIRenderer renderButton:_onDeliveryButton withClass:@"ButtonOrderCell:ButtonInNotOrder"];
}

@end
