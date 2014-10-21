//
//  OrderCell.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "VBCartCell.h"
#import "UILabel+NUI.h"
#import "UIButton+NUI.h"

@implementation VBCartCell

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
    _itemLabel.textColor = [[VBStyle style] cartNumberRowColor];
    _itemLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
    
    _titleLabel.textColor = [[VBStyle style] cartTitleColor];
    _titleLabel.font = [[VBStyle style] cartTitleFont];
}

- (IBAction)onOrderAmount:(id)sender {
    [_delegate onOrderCellSelect:_indexPath];
}

@end
