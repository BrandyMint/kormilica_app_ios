//
//  AboutLogoCell.m
//  Kormilica
//
//  Created by bespalown on 07/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutLogoCell.h"
#import "UILabel+NUI.h"

@implementation AboutLogoCell

-(void)layoutSubviews
{
    [_headerLabel setNuiClass:@"Label:NameCompany"];
    [_subHeaderLabel setNuiClass:@"Label:NameCompany"];
    
    _headerLabel.numberOfLines = 1;
    _subHeaderLabel.numberOfLines = 2;
}

@end
