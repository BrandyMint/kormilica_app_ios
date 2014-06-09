//
//  TableViewCell.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "TableViewCell.h"

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
    _price.textColor = COLOR_ORANGE;
    _price.font = [UIFont systemFontOfSize:18];
    
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:16];

    [_onOrder.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _onOrder.layer.cornerRadius = 4;
    _onOrder.layer.borderWidth = 1;
    _onOrder.layer.masksToBounds = YES;
    
    if (_count == 0) {
        [_onOrder setTitle:@"в заказ" forState:UIControlStateNormal];
        [_onOrder setBackgroundColor:[UIColor clearColor]];
        [_onOrder setTitleColor:COLOR_BLUE_ forState:UIControlStateNormal];
        _onOrder.layer.borderColor = COLOR_BLUE_.CGColor;
    }
    else {
        [_onOrder setTitle:[NSString stringWithFormat:@"в заказе: %d",_count] forState:UIControlStateNormal];
        [_onOrder setBackgroundColor:COLOR_GREEN_];
        [_onOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _onOrder.layer.borderColor = COLOR_GREEN_.CGColor;
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
