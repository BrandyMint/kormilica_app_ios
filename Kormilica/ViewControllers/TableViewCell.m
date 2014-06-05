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
    
    [_onOrder setTitle:@"В заказ" forState:UIControlStateNormal];
    [_onOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_onOrder setBackgroundColor:COLOR_SKY];
}

@end
