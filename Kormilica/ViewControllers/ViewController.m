//
//  ViewController.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "WYPopoverController.h"
#import "InfoVC.h"

@interface ViewController () <WYPopoverControllerDelegate, InfoVCDelegete>
{
    AppDelegate* appDelegate;
    
    UIButton* buttonHeader;
    WYPopoverController *wyPopoverController;
    InfoVC* popover;
    
    //bottom
    UILabel* buttomSelectLabel;
    UILabel* buttomDeliveryLabel;
}

@end

@implementation ViewController

-(void)initBottomView
{
    _bottomBarView.backgroundColor = COLOR_GRAY;
    
    buttomSelectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     CGRectGetWidth(_bottomBarView.frame),
                                                                     CGRectGetHeight(_bottomBarView.frame)/2)];
    buttomSelectLabel.font = [UIFont systemFontOfSize:14];
    buttomSelectLabel. textColor = [UIColor blackColor];
    buttomSelectLabel.text = @"Выберите блюдо на заказ";
    buttomSelectLabel.textAlignment = NSTextAlignmentCenter;
    buttomSelectLabel.contentMode = UIViewContentModeCenter;
    [_bottomBarView addSubview: buttomSelectLabel];
    
    buttomDeliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       CGRectGetHeight(_bottomBarView.frame)/2,
                                                                       CGRectGetWidth(_bottomBarView.frame),
                                                                       CGRectGetHeight(_bottomBarView.frame)/2)];
    buttomDeliveryLabel.font = [UIFont systemFontOfSize:14];
    buttomDeliveryLabel. textColor = COLOR_ORANGE;
    buttomDeliveryLabel.text = @"Доставка бесплатно от 500 руб.";
    buttomDeliveryLabel.textAlignment = NSTextAlignmentCenter;
    buttomDeliveryLabel.contentMode = UIViewContentModeCenter;
    [_bottomBarView addSubview: buttomDeliveryLabel];
}

-(void)initTopView
{
    _topBarView.backgroundColor = COLOR_ORANGE;
    
    buttonHeader = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonHeader setFrame:CGRectMake(10, 10, 100, CGRectGetHeight(_topBarView.frame) - 10)];
    [buttonHeader setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonHeader.titleLabel setFont:[UIFont systemFontOfSize:16]];
    buttonHeader.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    buttonHeader.titleLabel.textAlignment = NSTextAlignmentLeft;
    [buttonHeader addTarget:self action:@selector(onInfo) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView addSubview:buttonHeader];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self initBottomView];
    [self initTopView];

    [appDelegate.managers getBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        [_tableView reloadData];
        
        NSMutableString* title = [[NSMutableString alloc] initWithString:appDelegate.bundles.vendor.mobile_title];
        [title replaceOccurrencesOfString:@"<br>" withString:@"\n" options:0 range:NSMakeRange(0, title.length)];
        [buttonHeader setTitle:title forState:UIControlStateNormal];
        
    } failBlock:^(NSException * exception) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:exception.name message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegate.bundles.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Product* product = [appDelegate.bundles.products objectAtIndex:indexPath.row];
    cell.title.text = product.title;
    cell.price.text = [NSString stringWithFormat:@"%d %@",product.price.cents, product.price.currency];
    [cell.logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:[UIImage imageNamed:@""]];
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
}

#pragma mark WYPopoverController

- (void)onInfo
{
    if (wyPopoverController == nil)
    {
        WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        [appearance setTintColor:COLOR_ALPHA];
        
        popover = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoID"];
        popover.delegate = self;
        wyPopoverController = [[WYPopoverController alloc] initWithContentViewController:popover];
        wyPopoverController.delegate = (id)self;
        wyPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
        wyPopoverController.wantsDefaultContentAppearance = NO;
        
        [wyPopoverController presentPopoverFromRect:CGRectMake(0, 0, 0, 0)
                                             inView:self.view
                           permittedArrowDirections:WYPopoverArrowDirectionNone
                                           animated:YES
                                            options:WYPopoverAnimationOptionFadeWithScale];
        
    }
    else
    {
        [self popoverControllerDidDismissPopover:wyPopoverController];
    }
}

#pragma mark WYPopoverControllerDelegate
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if (controller == wyPopoverController)
    {
        [self hidePopover];
    }
}

-(void)hidePopover
{
    [wyPopoverController dismissPopoverAnimated:YES];
    wyPopoverController.delegate = nil;
    wyPopoverController = nil;
    popover.delegate = nil;
    popover = nil;
}


@end
