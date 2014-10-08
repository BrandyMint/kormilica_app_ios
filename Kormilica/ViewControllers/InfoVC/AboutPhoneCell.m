//
//  AboutPhoneCell.m
//  Kormilica
//
//  Created by bespalown on 07/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutPhoneCell.h"
#import "UIButton+NUI.h"
#import "UILabel+NUI.h"

@implementation AboutPhoneCell

-(void)layoutSubviews
{
    [NUIRenderer renderLabel:_phoneLabel withClass:@"Label:Telephone"];
    [NUIRenderer renderButton:_onPhoneButton withClass:@"ButtonOrderCell:ButtonInNotOrder"];
}

@end
