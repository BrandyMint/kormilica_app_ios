//
//  TableViewCell.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "TableViewCell.h"
#import "UIButton+NUI.h"
#import "UILabel+NUI.h"

@implementation TableViewCell

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
    _title.textColor = [[VBStyle style] nameProductColor];
    _title.font = [[VBStyle style] nameProductFont];
    
    _price.textColor = [[VBStyle style] amountProductColor];
    
    if (_count == 0) {
        [_onOrder setBackgroundImage:[[VBStyle style] notInOrderStateImage] forState:UIControlStateNormal];
        [_onOrder setTitle:nil forState:UIControlStateNormal];
    }
    else {
        [_onOrder setBackgroundImage:[[VBStyle style] inOrderStateImage] forState:UIControlStateNormal];
        [_onOrder setTitle:[NSString stringWithFormat:@"%ld",(long)_count] forState:UIControlStateNormal];
        [_onOrder setTitleColor:[[VBStyle style] inOrderStateCountColor] forState:UIControlStateNormal];
        [_onOrder.titleLabel setFont:[[VBStyle style] inOrderStateCountFont]];
        _onOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
}

- (IBAction)onOrder:(id)sender {
    if (_count == 0) {
        [_delegate onOrderCellSelect:_indexPath];
    }
    else {
        [_delegate onOrderCellAlreadySelect:_indexPath];
    }
}

@end
