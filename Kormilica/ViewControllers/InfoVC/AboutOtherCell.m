//
//  AboutOtherCell.m
//  Kormilica
//
//  Created by bespalown on 07/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutOtherCell.h"
#import "UIButton+NUI.h"
#import "UILabel+NUI.h"

@implementation AboutOtherCell

-(void)layoutSubviews
{
    [NUIRenderer renderButton:_onUpdateButton withClass:@"ButtonOrderCell:ButtonInNotOrder"];
    [NUIRenderer renderLabel:_lastUpdateLabel withClass:@"ButtonLastUpdate"];
    [NUIRenderer renderLabel:_versionLabel withClass:@"ButtonLastUpdate"];
    
    _cityLabel.textAlignment = NSTextAlignmentCenter;
}

@end
