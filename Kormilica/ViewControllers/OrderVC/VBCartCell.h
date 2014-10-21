//
//  OrderCell.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBAddToCartButton.h"

@class VBCartCell;
@protocol OrderCellDelegate
@optional
-(void)onOrderCellSelect:(NSIndexPath *)indexPath;
@end

@interface VBCartCell : UITableViewCell
@property (assign) id<OrderCellDelegate> delegate;

//public
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, assign) NSInteger count;

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet VBAddToCartButton *onOrderAmount;
- (IBAction)onOrderAmount:(id)sender;

@end
