//
//  OrderCell.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderCell;
@protocol OrderCellDelegate
@optional
-(void)onOrderCellSelect:(NSIndexPath *)indexPath;
@end

@interface OrderCell : UITableViewCell
@property (assign) id<OrderCellDelegate> delegate;

//public
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, assign) NSInteger count;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *sum;
@property (weak, nonatomic) IBOutlet UIButton *onOrderAmount;
- (IBAction)onOrderAmount:(id)sender;

@end
