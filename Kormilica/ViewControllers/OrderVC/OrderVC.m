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
#import "UILabel+NUI.h"
#import "UIView+NUI.h"
#import "NSString+Currency.h"
#import "IQActionSheetPicker.h"

@interface OrderVC () <OrderCellDelegate, IQActionSheetPickerDelegate>
{
    NSInteger selectedProductID;
    NSIndexPath* selectedIndexPath;
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
        //labelAllSum.text = [NSString stringWithFormat:@"Итого: %d р.", money.cents < 500 ? money.cents + 100 : money.cents];
    [self checkOrder];
    [self updateBottom];
}

-(void)updateBottom
{
    Money* money = [appDelegate.cart getTotalPriceFromProducts:appDelegate.bundles.products];
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:@"Итого: "];
    
    [attrString appendAttributedString:[[NSString stringWithFormat:@"%d",money.cents < appDelegate.bundles.vendor.minimal_price.cents/100 ? money.cents + 100 : money.cents] fromCurrency:money.currency]];
    labelAllSum.attributedText = attrString;

}

-(void)checkOrder
{
    BOOL isAllowed = [appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products];
    
    //[NSString stringWithFormat:@"%@\n %@", appDelegate.bundles.vendor.mobile_footer, appDelegate.bundles.vendor.mobile_delivery];
    labelAllSum.userInteractionEnabled  = _onOrderView.userInteractionEnabled = isAllowed;
    labelAllSum.textAlignment = NSTextAlignmentCenter;
    
    UIView* labelAllSumTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(labelAllSum.frame), 1)];
    [labelAllSumTopView setNuiClass:@"BottomView"];
    [labelAllSum addSubview:labelAllSumTopView];
    
    [labelOrderView setNuiClass:@"Label:WhiteText"];
    if (isAllowed) {
        [NUIRenderer renderView:labelOrderView withClass:@"OrderAllowed"];
        labelOrderView.text = @"Оформить заказ";
    }
    else {
        [NUIRenderer renderView:labelOrderView withClass:@"OrderNotAllowed"];
        NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:@"Минимальная сумма заказа - "];
        [attrString appendAttributedString:[[NSString stringWithFormat:@"%d",appDelegate.bundles.vendor.minimal_price.cents/100] fromCurrency:@"RUB"]];
        labelOrderView.attributedText = attrString;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Ваш заказ";
    
    _allSumView.backgroundColor = [UIColor clearColor];
    labelAllSum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_allSumView.frame), CGRectGetHeight(_allSumView.frame))];
    [labelAllSum setNuiClass:@"Label:AllSum"];
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
    return 80;
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
    
    //cell.sum.text = [NSString stringWithFormat:@"%d р./шт.",product.price.cents/100];
    NSMutableAttributedString* sumAttributedString = [[NSMutableAttributedString alloc]
                                             initWithAttributedString:[[NSString stringWithFormat:@"%d",product.price.cents] fromCurrencyCents:product.price.currency]];
    NSAttributedString* sumSubString = [[NSAttributedString alloc] initWithString:@" / шт."];
    [sumAttributedString appendAttributedString:sumSubString];
    cell.sum.attributedText = sumAttributedString;
    
    //[cell.onOrderAmount setTitle:[NSString stringWithFormat:@"%d шт. %d р.",cartItem.count, product.price.cents/100 * cartItem.count] forState:UIControlStateNormal];
    NSMutableAttributedString* buttonAttributedString = [[NSMutableAttributedString alloc]
                                                         initWithString:[NSString stringWithFormat:@"%d шт. ", cartItem.count]];
    [buttonAttributedString appendAttributedString:[[NSString stringWithFormat:@"%d",product.price.cents*cartItem.count] fromCurrencyCents:product.price.currency]];
    [cell.onOrderAmount setAttributedTitle:buttonAttributedString forState:UIControlStateNormal];
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
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    Money* money = [appDelegate.cart getTotalPriceFromProducts:appDelegate.bundles.products];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel* delivery = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 30)];
    delivery.text = @"Доставка";
    [delivery setNuiClass:@"Label:TitleProductCell"];
    delivery.textAlignment = NSTextAlignmentCenter;
    [view addSubview:delivery];
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]
                                             initWithAttributedString:[@"100" fromCurrency:@"RUB"]];
    
    UILabel* deliveryPrice = [[UILabel alloc] initWithFrame:CGRectMake(205, 15, 100, 30)];
    if (money.cents < appDelegate.bundles.vendor.minimal_price.cents/100) {
        deliveryPrice.attributedText = attrString;
    }
    else {
        deliveryPrice.text = @"Бесплатно";
    }
    
    [deliveryPrice setNuiClass:@"Label:TitleProductCell"];
    deliveryPrice.textAlignment = NSTextAlignmentCenter;
    deliveryPrice.layer.cornerRadius = 3;
    deliveryPrice.layer.masksToBounds = YES;
    deliveryPrice.layer.borderColor = [UIColor blackColor].CGColor;
    deliveryPrice.layer.borderWidth = 1;
    [view addSubview:deliveryPrice];
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
    UIView* topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), 1)];
    [topView setNuiClass:@"BottomView"];
    [view addSubview:topView];
    
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame)-1, CGRectGetWidth(view.frame), 1)];
    [bottomView setNuiClass:@"BottomView"];
    [view addSubview:bottomView];
    
    return view;
}

#pragma mark OrderCellDelegate

-(void)onOrderCellSelect:(NSIndexPath *)indexPath
{
    CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:indexPath.row];
    selectedProductID = cartItem.idProduct;
    selectedIndexPath = indexPath;
    //[self performSegueWithIdentifier:@"segEditProduct" sender:self];
    
    IQActionSheetPicker *picker = [[IQActionSheetPicker alloc] initWithTitle:@"Сколько заказать?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    picker.backgroundColor = COLOR_GRAY;
    
    NSMutableArray* arr = [NSMutableArray new];
    [arr addObject:@"Удалить из заказа"];
    for (int i = 1; i < 26; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:arr, nil]];
    [picker setDefaultValues:@[[NSString stringWithFormat:@"%d",[appDelegate.cart countProductInCartWithIdProduct:cartItem.idProduct]]]];
    [picker showInView:self.view];
}

#pragma mark IQActionSheetPickerDelegate

-(void)actionSheetPickerView:(IQActionSheetPicker *)pickerView didSelectTitles:(NSArray *)titles didSelectIndexes:(NSArray *)indexes
{
    if ([[indexes firstObject] integerValue] == 0) {
        //удаляем товар из заказа
        [appDelegate.cart addIdProduct:selectedProductID count:0];
        //[_tableView deleteRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        //меняем количество товаров для заказа
        NSUInteger count = [[indexes firstObject] integerValue];
        
        [appDelegate.cart addIdProduct:selectedProductID count:count];
        
        
        CartItem* cartItem = [[appDelegate.cart getItems] objectAtIndex:selectedIndexPath.row];
        Product* product = [cartItem productFromAllProducts:appDelegate.bundles.products];
        OrderCell *cell = (OrderCell *)[_tableView cellForRowAtIndexPath:selectedIndexPath];
        NSMutableAttributedString* buttonAttributedString = [[NSMutableAttributedString alloc]
                                                             initWithString:[NSString stringWithFormat:@"%d шт. ", count]];
        [buttonAttributedString appendAttributedString:[[NSString stringWithFormat:@"%d",product.price.cents*count] fromCurrencyCents:product.price.currency]];
        
        [cell.onOrderAmount setAttributedTitle:buttonAttributedString forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.indexPath = selectedIndexPath;
        cell.count = cartItem.count;
    }
    [self updateBottom];
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
