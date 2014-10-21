//
//  OrderVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "VBCartVC.h"
#import "VBCartCell.h"
#import "Product.h"
#import "DetailGoodsVC.h"
#import "OrderDetailVC.h"
#import "Order.h"
#import "CartItem.h"
#import "UILabel+NUI.h"
#import "UIView+NUI.h"
#import "NSString+Currency.h"
#import "IQActionSheetPickerView.h"

@interface VBCartVC () <OrderCellDelegate, IQActionSheetPickerViewDelegate>
{
    NSInteger selectedProductID;
    NSIndexPath* selectedIndexPath;
    UILabel* labelOrderView;
    IQActionSheetPickerView *picker;
}

@end

@implementation VBCartVC

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
        //labelAllSum.text = [NSString stringWithFormat:@"Итого: %d р.", money.cents < 500 ? money.cents + 100 : money.cents];
    [self checkOrder];
}

-(void)checkOrder
{
    BOOL isAllowed = [appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products];
    
    //[NSString stringWithFormat:@"%@\n %@", appDelegate.bundles.vendor.mobile_footer, appDelegate.bundles.vendor.mobile_delivery];
    _onOrderView.userInteractionEnabled = isAllowed;
    
    //[labelOrderView setNuiClass:@"Label:WhiteText"];
    labelOrderView.textColor = [UIColor whiteColor];
    labelOrderView.backgroundColor = [UIColor colorWithRed:0.820 green:0.827 blue:0.831 alpha:1.000];
    if (isAllowed) {
        //[NUIRenderer renderView:labelOrderView withClass:@"OrderAllowed"];
        labelOrderView.text = @"Оформить заказ";
    }
    else {
        //[NUIRenderer renderView:labelOrderView withClass:@"OrderNotAllowed"];
        NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:@"Минимальная сумма заказа - "];
        [attrString appendAttributedString:[[NSString stringWithFormat:@"%ld",(long)appDelegate.bundles.vendor.minimal_price.cents/100] fromCurrency:@"RUB" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]]];
        labelOrderView.attributedText = attrString;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Корзина";
    
    _onOrderView.backgroundColor = [UIColor clearColor];
    labelOrderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_onOrderView.frame), CGRectGetHeight(_onOrderView.frame))];
    labelOrderView.textColor = [UIColor whiteColor];
    labelOrderView.textAlignment = NSTextAlignmentCenter;
    labelOrderView.contentMode = UIViewContentModeCenter;
    labelOrderView.textAlignment = NSTextAlignmentCenter;
    labelOrderView.numberOfLines = 2;
    labelOrderView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    _onOrderView.userInteractionEnabled = YES;
    [_onOrderView addSubview:labelOrderView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSendOrder:)];
    [_onOrderView addGestureRecognizer:tap];
    
    [self checkOrder];
    
    picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Заказать" delegate:self];
    picker.backgroundColor = COLOR_GRAY;
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     appDelegate.dataArrayForPicker,
                                     nil]];
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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    VBCartCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[VBCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.itemLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    
    CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:indexPath.row];
    Product* product = [cartItem productFromAllProducts:appDelegate.bundles.products];
    cell.titleLabel.text = product.title;
    
    [cell.onOrderAmount setAmount:[NSNumber numberWithDouble:product.price.cents] currency:product.price.currency];
    [cell.onOrderAmount goodsCountInCart:[NSNumber numberWithLong:[appDelegate.cart countProductInCartWithIdProduct:product.idProduct]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.indexPath = indexPath;
    cell.count = cartItem.count;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:indexPath.row];
    selectedProductID = cartItem.idProduct;
    [self performSegueWithIdentifier:@"segEditProduct" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    Money* money = [appDelegate.cart getTotalPriceFromProducts:appDelegate.bundles.products];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 60)];
    view.backgroundColor = [[VBStyle style] cartItogoBackGroundColor];
    
    UILabel *itogoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CGRectGetHeight(view.frame))];
    itogoLabel.backgroundColor = [UIColor clearColor];
    itogoLabel.textColor = [[VBStyle style] cartItogoColor];
    itogoLabel.text = @"Итого:";
    itogoLabel.font = [[VBStyle style] cartItogoFont];
    [view addSubview:itogoLabel];
    
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(view.frame) - 150, 0, 130, CGRectGetHeight(view.frame))];
    sumLabel.backgroundColor = [UIColor clearColor];
    sumLabel.textColor = [[VBStyle style] cartItogoColor];
    sumLabel.textAlignment = NSTextAlignmentRight;
    sumLabel.attributedText = [[NSAttributedString alloc] initWithAttributedString:
                               [[NSString stringWithFormat:@"%ld",(long)money.cents * 100]
                                                                                     fromCurrencyCents:money.currency
                                                                                     font:[[VBStyle style] cartItogoFont]]];
    [view addSubview:sumLabel];
    
    /*
    UILabel* delivery = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 30)];
    delivery.text = @"Доставка";
    [delivery setNuiClass:@"Label:TitleProductCell"];
    delivery.textAlignment = NSTextAlignmentCenter;
    [view addSubview:delivery];
    
    UILabel* deliveryPrice = [[UILabel alloc] initWithFrame:CGRectMake(205, 15, 100, 30)];
    deliveryPrice.textAlignment = NSTextAlignmentCenter;
    
    if (money.cents < appDelegate.bundles.vendor.minimal_price.cents/100) {
        NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]
                                                 initWithAttributedString:[@"100" fromCurrency:@"RUB"]];
        deliveryPrice.attributedText = attrString;
    }
    else {
        NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:@"Бесплатно"];
        [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:14] range:NSMakeRange(0, attrString.length)];
        deliveryPrice.attributedText = attrString;
        
    }
    */
    //[view addSubview:deliveryPrice];
    
/*
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(205, 15, 100, 30)];
    [button setTitle:money.cents < 500 ? @"100 руб" : @"Бесплатно" forState:UIControlStateNormal];
    [button setNuiClass:@"ButtonOrderCell:ButtonDelivery"];
    [view addSubview:button];

    UILabel* description = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(delivery.frame) + 5, 300, 20)];
    description.text = money.cents < 500 ? @"Бесплатная доставка при заказе на сумму от 500 р." : @"";
    [description setNuiClass:@"Label:OrderInfo"];
    description.textAlignment = NSTextAlignmentCenter;
    [view addSubview:description];
*/
    return view;
}

#pragma mark OrderCellDelegate

-(void)onOrderCellSelect:(NSIndexPath *)indexPath
{
    CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:indexPath.row];
    selectedProductID = cartItem.idProduct;
    selectedIndexPath = indexPath;
    //[self performSegueWithIdentifier:@"segEditProduct" sender:self];
    
    [picker selectIndexes:@[[NSNumber numberWithInteger:[appDelegate.cart countProductInCartWithIdProduct:cartItem.idProduct]]] animated:YES];
    [picker showInViewController:self];
}

#pragma mark IQActionSheetPickerDelegate

- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles;
{
    NSInteger indexOfArray = [appDelegate.dataArrayForPicker indexOfObject:titles.firstObject];
    
    if (indexOfArray == 0) {
        //удаляем товар из заказа
        [appDelegate.cart addIdProduct:selectedProductID count:0];
    }
    else {
        //меняем количество товаров для заказа
        [appDelegate.cart addIdProduct:selectedProductID count:indexOfArray];
        
        CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:selectedIndexPath.row];
        Product* product = [cartItem productFromAllProducts:appDelegate.bundles.products];
        VBCartCell *cell = (VBCartCell *)[_tableView cellForRowAtIndexPath:selectedIndexPath];
        NSMutableAttributedString* buttonAttributedString = [[NSMutableAttributedString alloc]
                                                             initWithString:[NSString stringWithFormat:@"%ld шт. ", (long)indexOfArray]];
        [buttonAttributedString appendAttributedString:[[NSString stringWithFormat:@"%ld",product.price.cents*indexOfArray] fromCurrencyCents:product.price.currency]];
        
        [cell.onOrderAmount setAttributedTitle:buttonAttributedString forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.indexPath = selectedIndexPath;
        cell.count = cartItem.count;
    }

    [self checkOrder];
    [_tableView reloadData];
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