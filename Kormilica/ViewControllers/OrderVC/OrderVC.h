//
//  OrderVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterVC.h"

@interface OrderVC : MasterVC
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *allSumView;
@property (weak, nonatomic) IBOutlet UIView *onOrderView;

@end
