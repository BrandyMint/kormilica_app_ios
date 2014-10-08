//
//  ViewController.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterVC.h"
#import "BuyView.h"
#import "SVSegmentedControl.h"

@interface ViewController : MasterVC

@property (weak, nonatomic) IBOutlet UIView *segmentedControlView;
@property (weak, nonatomic) IBOutlet BuyView *onBuy;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
