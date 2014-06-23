//
//  OrderCell.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "OrderCell.h"
#import "UILabel+NUI.h"
#import "UIButton+NUI.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    _title.numberOfLines = 2;
    [_onOrderAmount.titleLabel setFont:[UIFont systemFontOfSize:14]];
}

- (IBAction)onOrderAmount:(id)sender {
    [_delegate onOrderCellSelect:_indexPath];
}

@end
