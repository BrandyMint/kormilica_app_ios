//
//  OrderCell.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "OrderCell.h"

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
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:14];
    _title.numberOfLines = 2;
    
    _sum.textColor = [UIColor blackColor];
    [_sum setFont:[UIFont systemFontOfSize:14]];

    [_onOrderAmount.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _onOrderAmount.layer.cornerRadius = 4;
    _onOrderAmount.layer.borderWidth = 1;
    _onOrderAmount.layer.masksToBounds = YES;
    [_onOrderAmount setBackgroundColor:COLOR_GREEN_];
    [_onOrderAmount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _onOrderAmount.layer.borderColor = COLOR_GREEN_.CGColor;
}

- (IBAction)onOrderAmount:(id)sender {
    [_delegate onOrderCellSelect:_indexPath];
}

@end
