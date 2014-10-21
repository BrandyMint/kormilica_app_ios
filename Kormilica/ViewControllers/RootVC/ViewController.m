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
#import "IQActionSheetPickerView.h"

@interface ViewController () <TableViewCellDelegate, onBuyViewDelegate, IQActionSheetPickerViewDelegate>
{
    AboutVC* popover;
    
    NSArray* dataArray;
    NSInteger selectedIDCategory;
    NSInteger selectedIDProduct;
    
    Product *selectProduct;
    NSIndexPath *selectIndexPathProduct;
    
    BOOL isBuy;
    IQActionSheetPickerView *picker;
}
@property (nonatomic, strong) SVSegmentedControl *segmentedControl;
@end

@implementation ViewController

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
    [_statusCartButton setCountProductInCard:[appDelegate.cart getItemsCount]];
    
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    _onBuy.userInteractionEnabled = [appDelegate.cart getItemsCount] > 0 ? YES : NO;
    [self initDataArrayWithCategoriesID:selectedIDCategory];
    
    [_segmentedControl setSelectedSegmentIndex:appDelegate.selecrtedIndexCategory animated:YES];
    
    Categories* categories = [appDelegate.bundles.categories objectAtIndex:appDelegate.selecrtedIndexCategory];
    [self initDataArrayWithCategoriesID:categories.idCategories];
    selectedIDCategory = categories.idCategories;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _onBuy.delegate = self;
    _onBuy.userInteractionEnabled = NO;
    
    [appDelegate.managers getLocalBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        
        [self initText];
        
        Product* product = [bundles.products firstObject];
        selectedIDCategory = product.idCategory;
        [self initDataArrayWithCategoriesID:selectedIDCategory];
        
        appDelegate.cart.vendor = bundles.vendor;
    }];
    
    NSMutableArray *mut = [NSMutableArray new];
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        [mut addObject:[[appDelegate.bundles.categories objectAtIndex:i] name]];
    }
    self.title = mut[appDelegate.selecrtedIndexCategory];
    
    [_statusCartButton setCountProductInCard:[appDelegate.cart getItemsCount]];

    picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Сколько заказать?" delegate:self];
    picker.backgroundColor = COLOR_GRAY;
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     appDelegate.dataArrayForPicker,
                                     nil]];
    
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
    return 60;
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
    
    cell.price.attributedText = [[NSAttributedString alloc] initWithAttributedString:[[NSString stringWithFormat:@"%ld",(long)product.price.cents] fromCurrencyCents:product.price.currency font:[[VBStyle style] amountProductFont]]];
    
    [cell.logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:[UIImage imageNamed:@"typeImage.png"]];
    
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
    selectProduct = product;
    selectIndexPathProduct = indexPath;
    selectedIDProduct = product.idProduct;
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self performSegueWithIdentifier:@"segDetail" sender:self];

    [picker selectIndexes:@[[NSNumber numberWithInteger:[appDelegate.cart countProductInCartWithIdProduct:product.idProduct]]] animated:YES];
    [picker showInViewController:self];
}

#pragma mark IQActionSheetPickerDelegate

- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles;
{
    NSInteger indexOfArray = [appDelegate.dataArrayForPicker indexOfObject:titles.firstObject];
    
    if (indexOfArray == 0) {
        //удаляем товар из заказа
        [appDelegate.cart addIdProduct:selectProduct.idProduct count:0];
        [_statusCartButton setCountProductInCard:[appDelegate.cart getItemsCount]];
    }
    else {
        //меняем количество товаров для заказа
        [appDelegate.cart addIdProduct:selectProduct.idProduct count:indexOfArray];
        [_statusCartButton setCountProductInCard:[appDelegate.cart getItemsCount]];
    }
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    
    [_tableView reloadRowsAtIndexPaths:@[selectIndexPathProduct] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)onOrderCellSelect:(NSIndexPath *)indexPath
{
    Product* product = [dataArray objectAtIndex:indexPath.row];
    [appDelegate.cart addIdProduct:product.idProduct count:1];
     
    [self initDataArrayWithCategoriesID:selectedIDCategory];
    
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    _onBuy.userInteractionEnabled = [appDelegate.cart getItemsCount] > 0 ? YES : NO;
    
    [_statusCartButton setCountProductInCard:[appDelegate.cart getItemsCount]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segDetail"]){
        DetailGoodsVC* destination = [segue destinationViewController];
        destination.idProduct = selectedIDProduct;
    }
}

- (IBAction)statusCartButton:(id)sender {
    [self performSegueWithIdentifier:@"segBuy" sender:self];
}

@end
