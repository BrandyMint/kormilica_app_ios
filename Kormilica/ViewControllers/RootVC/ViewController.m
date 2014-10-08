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

static int positionButtonInfo = 46;

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
    infoButton.frame = CGRectMake(0,0,positionButtonInfo,35);
}

-(void)initScrollViewContent
{
    [_segmentedControlView setBackgroundColor: COLOR_GRAY];
    
    [_segmentedControl removeFromSuperview];
    _segmentedControl = nil;
    
    NSMutableArray *mut = [NSMutableArray new];
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        [mut addObject:[[appDelegate.bundles.categories objectAtIndex:i] name]];
    }

    _segmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:mut];
    _segmentedControl.frame = CGRectMake(0, 0, 320, 40);
    _segmentedControl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    _segmentedControl.textColor = [UIColor whiteColor];
    _segmentedControl.backgroundTintColor = [UIColor clearColor];
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.innerShadowColor = [UIColor clearColor];
    _segmentedControl.height = 35;
    _segmentedControl.textShadowColor = [UIColor clearColor];
    _segmentedControl.textShadowOffset = CGSizeZero;
    _segmentedControl.thumb.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    _segmentedControl.thumb.backgroundColor = [UIColor clearColor];
    _segmentedControl.thumb.textShadowColor = [UIColor clearColor];
    _segmentedControl.thumb.textShadowOffset = CGSizeZero;
    _segmentedControl.thumb.gradientIntensity = 0;
    //_segmentedControl.center = CGPointMake(160, 20);
    _segmentedControl.changeHandler = ^(NSUInteger newIndex) {
        Categories* categories = [appDelegate.bundles.categories objectAtIndex:newIndex];
        [self initDataArrayWithCategoriesID:categories.idCategories];
        selectedIDCategory = categories.idCategories;
        appDelegate.selecrtedIndexCategory = newIndex;
    };
    [_segmentedControlView addSubview:_segmentedControl];
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
    
    [self initScrollViewContent];
    
    [_segmentedControl setSelectedSegmentIndex:appDelegate.selecrtedIndexCategory animated:YES];
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
        
        Product* product = [bundles.products firstObject];
        selectedIDCategory = product.idCategory;
        [self initDataArrayWithCategoriesID:selectedIDCategory];
        
        appDelegate.cart.vendor = bundles.vendor;
    }];

    picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Сколько заказать?" delegate:self];
    picker.backgroundColor = COLOR_GRAY;
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     appDelegate.dataArrayForPicker,
                                     nil]];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.tableView addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:swipeRight];
}

-(void)swipeLeft:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"<-");
    
    if (appDelegate.selecrtedIndexCategory > 0) {
        appDelegate.selecrtedIndexCategory--;
    }
    //else
        //appDelegate.selecrtedIndexCategory = appDelegate.bundles.categories.count - 1;
    
    Categories* categories = [appDelegate.bundles.categories objectAtIndex:appDelegate.selecrtedIndexCategory];
    [self initDataArrayWithCategoriesID:categories.idCategories];
    selectedIDCategory = categories.idCategories;
    [_segmentedControl setSelectedSegmentIndex:appDelegate.selecrtedIndexCategory animated:YES];
}

-(void)swipeRight:(UISwipeGestureRecognizer *)swipe
{
    NSLog( @"->");

    if (appDelegate.selecrtedIndexCategory < appDelegate.bundles.categories.count - 1) {
        appDelegate.selecrtedIndexCategory++;
    }
    //else
        //appDelegate.selecrtedIndexCategory = 0;
    Categories* categories = [appDelegate.bundles.categories objectAtIndex:appDelegate.selecrtedIndexCategory];
    [self initDataArrayWithCategoriesID:categories.idCategories];
    selectedIDCategory = categories.idCategories;
    [_segmentedControl setSelectedSegmentIndex:appDelegate.selecrtedIndexCategory animated:YES];
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
    
    cell.price.attributedText = [[NSAttributedString alloc] initWithAttributedString:[[NSString stringWithFormat:@"%d",product.price.cents] fromCurrencyCents:product.price.currency]];
    
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
    }
    else {
        //меняем количество товаров для заказа
        [appDelegate.cart addIdProduct:selectProduct.idProduct count:indexOfArray];
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
