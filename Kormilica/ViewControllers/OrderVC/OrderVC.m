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

@interface OrderVC () <OrderCellDelegate>
{
    NSInteger selectedProductID;
    UILabel* labelAllSum;
    
    Order* order;
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
    [order updateOrderWithCart:appDelegate.cart];
    [_tableView reloadData];
    
    labelAllSum.text = [NSString stringWithFormat:@"Итого: %d р.", order.total_price.cents];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Ваш заказ";
    
    order = [[Order alloc] initWithCartItems:[appDelegate.cart getItems]
                                 total_price:[appDelegate.cart getTotalPriceFromProducts:appDelegate.bundles.products]
                                fromProducts:appDelegate.bundles.products];

    _allSumView.backgroundColor = [UIColor clearColor];
    labelAllSum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_allSumView.frame), CGRectGetHeight(_allSumView.frame))];
    labelAllSum.font = [UIFont systemFontOfSize:18];
    labelAllSum.textColor = [UIColor blackColor];
    labelAllSum.textAlignment = NSTextAlignmentCenter;
    labelAllSum.layer.borderColor = COLOR_GRAY.CGColor;
    labelAllSum.layer.borderWidth = 1;
    [_allSumView addSubview:labelAllSum];
    
    
    _onOrderView.backgroundColor = [UIColor clearColor];
    UILabel* labelOrderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_onOrderView.frame), CGRectGetHeight(_onOrderView.frame))];
    labelOrderView.font = [UIFont systemFontOfSize:18];
    labelOrderView.textColor = [UIColor whiteColor];
    labelOrderView.textAlignment = NSTextAlignmentCenter;
    labelOrderView.contentMode = UIViewContentModeCenter;
    labelOrderView.backgroundColor = COLOR_BLUE_;
    labelOrderView.textAlignment = NSTextAlignmentCenter;
    labelOrderView.numberOfLines = 1;
    labelOrderView.text = @"Отправить заказ";
    _onOrderView.userInteractionEnabled = YES;
    labelAllSum.userInteractionEnabled = YES;
    [_onOrderView addSubview:labelOrderView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSendOrder:)];
    [_onOrderView addGestureRecognizer:tap];
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
    return order.items.count;
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
    
    OrderItem* orderItem = [order.items objectAtIndex:indexPath.row];
    
    cell.title.text = orderItem.product.title;
    cell.sum.text = [NSString stringWithFormat:@"%d р./шт.",orderItem.product.price.cents/100];
    [cell.onOrderAmount setTitle:[NSString stringWithFormat:@"%d шт. %d р.",orderItem.count, orderItem.product.price.cents/100 * orderItem.count] forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.indexPath = indexPath;
    cell.count = orderItem.count;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {

}

#pragma mark OrderCellDelegate

-(void)onOrderCellSelect:(NSIndexPath *)indexPath
{
    OrderItem* orderItem = [order.items objectAtIndex:indexPath.row];
    selectedProductID = orderItem.product.idProduct;
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
         OrderDetailVC* destination = [segue destinationViewController];
         destination.order = order;
     }
 }


@end
