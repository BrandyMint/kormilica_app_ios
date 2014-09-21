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
    [NUIRenderer renderLabel:_title withClass:@"LabelDefault:TitleProductCell"];
    
    if (_count == 0) {
        [_onOrder setTitle:@"в заказ" forState:UIControlStateNormal];
        [NUIRenderer renderButton:_onOrder withClass:@"ButtonOrderCell:ButtonInNotOrder"];
    }
    else {
        [_onOrder setTitle:[NSString stringWithFormat:@"в заказе: %d",_count] forState:UIControlStateNormal];
        [NUIRenderer renderButton:_onOrder withClass:@"ButtonOrderCell:ButtonInOrder"];
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
