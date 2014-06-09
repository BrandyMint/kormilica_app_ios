//
//  TableViewCell.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewCell;
@protocol TableViewCellDelegate
@optional
-(void)onOrderCellAlreadySelect:(NSIndexPath *)indexPath;
-(void)onOrderCellSelect:(NSIndexPath *)indexPath;
@end

@interface TableViewCell : UITableViewCell

//public
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, assign) NSInteger count;

@property (assign) id<TableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *onOrder;
- (IBAction)onOrder:(id)sender;

@end
