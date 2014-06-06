//
//  ViewController.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "WYPopoverController.h"
#import "InfoVC.h"
#import "NSString-HTML.h"
#import "HMSegmentedControl.h"
#import "DetailGoodsVC.h"
#import "UIButton+Buy.h"

@interface ViewController () <WYPopoverControllerDelegate, InfoVCDelegete, TableViewCellDelegate>
{
    AppDelegate* appDelegate;
    WYPopoverController *wyPopoverController;
    InfoVC* popover;
    
    NSArray* dataArray;
    NSInteger selectedIDCategory;
    NSInteger selectedIDProduct;
    
    BOOL isBuy;
}

@end

@implementation ViewController

-(void)initTopView
{
    if (IS_IOS7) {
        //self.navigationController.navigationBar.barTintColor = COLOR_ORANGE;
        //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        //self.navigationController.navigationBar.translucent = NO;
    }
    else
    {
        //[self.navigationController.navigationBar setTintColor:COLOR_ORANGE];
    }
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    //[infoButton setTintColor:[UIColor whiteColor]];
    [infoButton addTarget:self action:@selector(onInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setLeftBarButtonItem:modalButton animated:YES];
}

-(void)initScrollViewContent
{
    UIFont* font = [UIFont systemFontOfSize:16];
    CGFloat weightButtons = 0;
    
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        NSString* title = [[appDelegate.bundles.categories objectAtIndex:i] name];
        //CGSize size = [title sizeText:title width:1 font:font];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(100*i, 0, 100, 40)];
        [button setTitleColor:COLOR_BLUE_ forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:font];
        [button setTag:i+1];
        [button addTarget:self action:@selector(slideAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = COLOR_SKY.CGColor;
        button.layer.borderWidth = 0;
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [_scrollView addSubview:button];
        
        if (i == 0) {
            button.layer.borderWidth = 1;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:COLOR_BLUE_];
        }
        
        weightButtons += CGRectGetWidth(button.frame);
    }
    
    _scrollView.backgroundColor = COLOR_GRAY;
    _scrollView.contentSize = CGSizeMake(weightButtons, CGRectGetHeight(_scrollView.frame));
    _scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)slideAction:(id)sender
{
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        UIButton* button = (UIButton *)[self.view viewWithTag:i+1];
        button.layer.borderWidth = 0;
        [button setTitleColor:COLOR_BLUE_ forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
    }
    UIButton* button = (UIButton *)sender;
    button.layer.borderWidth = 1;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:COLOR_BLUE_];
    
    Categories* categories = [appDelegate.bundles.categories objectAtIndex:button.tag - 1];
    [self initDataArrayWithCategoriesID:categories.idCategories];
    selectedIDCategory = categories.idCategories;
    
    if (_scrollView.contentSize.width > self.view.frame.size.width) {   //если ширина кнопок с категориями больше ширины экрана, то будут скролится
        if (button.tag == 1) {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (button.tag == appDelegate.bundles.categories.count) {
            [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width - _scrollView.bounds.size.width, 0) animated:YES];
        }
        else {
            CGPoint point = [button convertPoint:CGPointZero toView:_scrollView];
            [_scrollView setContentOffset:CGPointMake(point.x - CGRectGetWidth(self.view.frame)/2 + CGRectGetWidth(button.frame)/2, 0) animated:YES];
        }
    }
}

-(void)initText
{
    [_onBuy isAllowed:NO];

    NSMutableString* title = [[NSMutableString alloc] initWithString:appDelegate.bundles.vendor.mobile_title];
    [title replaceOccurrencesOfString:@"<br>" withString:@" " options:0 range:NSMakeRange(0, title.length)];
    self.navigationItem.title = title;
}

-(void)initDataArrayWithCategoriesID:(NSInteger)idCategories
{
    NSMutableArray* arr = [NSMutableArray new];
    for (Product* product in appDelegate.bundles.products) {
        if (product.idCategory == idCategories) {
            [arr addObject:product];
        }
    }
    dataArray = arr;
    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self initDataArrayWithCategoriesID:selectedIDCategory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self initTopView];

    [appDelegate.managers getBundles:^(Bundles* bundles) {
        
        appDelegate.bundles = bundles;
        
        [self initText];
        [self initScrollViewContent];
        
        Product* product = [bundles.products firstObject];
        selectedIDCategory = product.idCategory;
        [self initDataArrayWithCategoriesID:selectedIDCategory];
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
    return dataArray.count;
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
    
    Product* product = [dataArray objectAtIndex:indexPath.row];
    cell.title.text = product.title;
    cell.price.text = [NSString stringWithFormat:@"%d %@",product.price.cents, product.price.currency];
    [cell.logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:[UIImage imageNamed:@""]];
    
    cell.indexPath = indexPath;
    cell.count = product.count;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    Product* product = [dataArray objectAtIndex:indexPath.row];
    selectedIDProduct = product.idProduct;
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"segDetail" sender:self];
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

#pragma mark TableViewCell Delegate

-(void)onOrderCellAlreadySelect:(NSIndexPath *)indexPath
{
    Product* product = [dataArray objectAtIndex:indexPath.row];
    selectedIDProduct = product.idProduct;
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"segDetail" sender:self];
}

-(void)onOrderCellSelect:(NSIndexPath *)indexPath
{
    Product* product = [dataArray objectAtIndex:indexPath.row];
    
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:appDelegate.bundles.products];
    for (int i = 0; i < arr.count; i++) {
        Product* productArr = [arr objectAtIndex:i];
        if (product.idProduct == productArr.idProduct && product.idCategory == productArr.idCategory) {
            productArr.count = 1;
            [arr replaceObjectAtIndex:i withObject:productArr];
        }
    }
    appDelegate.bundles.products = arr;
    
    [self initDataArrayWithCategoriesID:selectedIDCategory];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segDetail"]){
        DetailGoodsVC* destination = [segue destinationViewController];
        destination.idProduct = selectedIDProduct;
    }
}

- (IBAction)onBuy:(id)sender {
    
}

@end
