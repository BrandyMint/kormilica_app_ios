//
//  OrderVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"
#import "Product.h"
#import "DetailGoodsVC.h"
#import "OrderDetailVC.h"
#import "Order.h"
#import "CartItem.h"

@interface OrderVC () <OrderCellDelegate>
{
    NSInteger selectedProductID;
    UILabel* labelAllSum;
    UILabel* labelOrderView;
}

@end

@implementation OrderVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
    Money* money = [appDelegate.cart getTotalPriceFromProducts:appDelegate.bundles.products];
    labelAllSum.text = [NSString stringWithFormat:@"Итого: %d р.", money.cents];
    [self checkOrder];
}

-(void)checkOrder
{
    BOOL isAllowed = [appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products];
    labelOrderView.text = isAllowed ? @"Отправить заказ" :
                [NSString stringWithFormat:@"%@\n %@", appDelegate.bundles.vendor.mobile_footer, appDelegate.bundles.vendor.mobile_delivery];
    labelAllSum.userInteractionEnabled  = _onOrderView.userInteractionEnabled = isAllowed;
    labelOrderView.backgroundColor = isAllowed ? COLOR_BLUE_ : COLOR_GRAY;
    labelOrderView.font = [UIFont systemFontOfSize:isAllowed ? 18 : 14];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Ваш заказ";
    
    _allSumView.backgroundColor = [UIColor clearColor];
    labelAllSum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_allSumView.frame), CGRectGetHeight(_allSumView.frame))];
    labelAllSum.font = [UIFont systemFontOfSize:18];
    labelAllSum.textColor = [UIColor blackColor];
    labelAllSum.textAlignment = NSTextAlignmentCenter;
    labelAllSum.layer.borderColor = COLOR_GRAY.CGColor;
    labelAllSum.layer.borderWidth = 1;
    [_allSumView addSubview:labelAllSum];
    
    _onOrderView.backgroundColor = [UIColor clearColor];
    labelOrderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_onOrderView.frame), CGRectGetHeight(_onOrderView.frame))];
    labelOrderView.textColor = [UIColor whiteColor];
    labelOrderView.textAlignment = NSTextAlignmentCenter;
    labelOrderView.contentMode = UIViewContentModeCenter;
    labelOrderView.textAlignment = NSTextAlignmentCenter;
    labelOrderView.numberOfLines = 2;
    _onOrderView.userInteractionEnabled = YES;
    [_onOrderView addSubview:labelOrderView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSendOrder:)];
    [_onOrderView addGestureRecognizer:tap];
    
    [self checkOrder];
}

- (void)onSendOrder:(UIGestureRecognizer *)gestureRecognizer {
    [self performSegueWithIdentifier:@"segOrder" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.cart getItemsCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:indexPath.row];
    Product* product = [cartItem productFromAllProducts:appDelegate.bundles.products];
    
    cell.title.text = product.title;
    cell.sum.text = [NSString stringWithFormat:@"%d р./шт.",product.price.cents/100];
    [cell.onOrderAmount setTitle:[NSString stringWithFormat:@"%d шт. %d р.",cartItem.count, product.price.cents/100 * cartItem.count] forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.indexPath = indexPath;
    cell.count = cartItem.count;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {

}

#pragma mark OrderCellDelegate

-(void)onOrderCellSelect:(NSIndexPath *)indexPath
{
    CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:indexPath.row];
    selectedProductID = cartItem.idProduct;
    [self performSegueWithIdentifier:@"segEditProduct" sender:self];
}

#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segEditProduct"]) {
        DetailGoodsVC* destination = [segue destinationViewController];
        destination.idProduct = selectedProductID;
    }
    if ([segue.identifier isEqualToString:@"segOrder"]) {
        //OrderDetailVC* destination = [segue destinationViewController];
    }
}


@end
