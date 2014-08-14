//
//  ViewController.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "AboutVC.h"
#import "NSString-HTML.h"
#import "HMSegmentedControl.h"
#import "DetailGoodsVC.h"
#import "BuyView.h"
#import "UIImageView+AFNetworking.h"
#import "MapVC.h"
#import "NSString+Currency.h"
#import "UIButton+NUI.h"

@interface ViewController () <TableViewCellDelegate, onBuyViewDelegate>
{
    AboutVC* popover;
    
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
    CGFloat weightButtons = 0;
    
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        NSString* title = [[appDelegate.bundles.categories objectAtIndex:i] name];

        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(100*i, 0, 100, 40)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTag:i+1];
        [button addTarget:self action:@selector(slideAction:) forControlEvents:UIControlEventTouchUpInside];
        [NUIRenderer renderButton:button withClass:@"ButtonCategory:ButtonCategoryNoSelected"];
        [_scrollView addSubview:button];
        
        if (i == 0) {
            [NUIRenderer renderButton:button withClass:@"ButtonCategory:ButtonCategorySelected"];
        }
        
        weightButtons += CGRectGetWidth(button.frame);
    }
    
    //_scrollView.backgroundColor = COLOR_GRAY;
    _scrollView.contentSize = CGSizeMake(weightButtons, CGRectGetHeight(_scrollView.frame));
    _scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)slideAction:(id)sender
{
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        UIButton* button = (UIButton *)[self.view viewWithTag:i+1];
        [NUIRenderer renderButton:button withClass:@"ButtonCategory:ButtonCategoryNoSelected"];
    }
    UIButton* button = (UIButton *)sender;
    button.layer.borderWidth = 1;
    [NUIRenderer renderButton:button withClass:@"ButtonCategory:ButtonCategorySelected"];
    
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
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    _onBuy.userInteractionEnabled = [appDelegate.cart getItemsCount] > 0 ? YES : NO;
    [self initDataArrayWithCategoriesID:selectedIDCategory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _onBuy.delegate = self;
    _onBuy.userInteractionEnabled = NO;
    [self initTopView];
    
    [appDelegate.managers getLocalBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        
        [self initText];
        [self initScrollViewContent];
        
        Product* product = [bundles.products firstObject];
        selectedIDCategory = product.idCategory;
        [self initDataArrayWithCategoriesID:selectedIDCategory];
        
        appDelegate.cart.vendor = bundles.vendor;
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
    return 80;
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
    cell.price.attributedText = [[NSString stringWithFormat:@"%d",product.price.cents] fromCurrencyCents:product.price.currency];
    
    [cell.logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:[UIImage imageNamed:@""]];

    cell.indexPath = indexPath;
    //смотрим в корзину, если там есть такой же товар, то указываем количество
    cell.count = [appDelegate.cart countProductInCartWithIdProduct:product.idProduct];
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
    [self performSegueWithIdentifier:@"segAbout" sender:self];
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
    [appDelegate.cart addIdProduct:product.idProduct count:1];
     
    [self initDataArrayWithCategoriesID:selectedIDCategory];
    
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    _onBuy.userInteractionEnabled = [appDelegate.cart getItemsCount] > 0 ? YES : NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segDetail"]){
        DetailGoodsVC* destination = [segue destinationViewController];
        destination.idProduct = selectedIDProduct;
    }
}

-(void)onBuyAction
{
    [self performSegueWithIdentifier:@"segBuy" sender:self];
}

@end
