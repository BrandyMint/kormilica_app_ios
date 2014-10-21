//
//  DetailGoodsVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "DetailGoodsVC.h"
#import "IQActionSheetPickerView.h"
#import "DetailImageVC.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+NUI.h"
#import "UILabel+NUI.h"
#import "UITextView+NUI.h"
#import "NSString+Currency.h"
#import "VBAddToCartButton.h"

@interface DetailGoodsVC () <IQActionSheetPickerViewDelegate, onBuyViewDelegate>
{
    Product* product;
    IQActionSheetPickerView *picker;
}
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleProductLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UITextView *textField;
@property (strong, nonatomic) VBAddToCartButton *onOrder;

@end

@implementation DetailGoodsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _onBuy.delegate = self;

    for (Product* product_ in appDelegate.bundles.products) {
        if (product_.idProduct == _idProduct) {
            product = product_;
        }
    }
    
    picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Количество" delegate:self];
    picker.backgroundColor = COLOR_GRAY;
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     appDelegate.dataArrayForPicker,
                                     nil]];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:[UIImage imageNamed:@"typeImage.png"]];
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDetailImage)];
    [_imageView addGestureRecognizer:tap];
    _imageView.userInteractionEnabled = YES;
    
    _titleProductLabel = [[UILabel alloc] init];
    _titleProductLabel.text = product.title;
    _titleProductLabel.contentMode = UIViewContentModeTop;
    _titleProductLabel.numberOfLines = 2;
    _titleProductLabel.textColor = [[VBStyle style] nameProductColor];
    _titleProductLabel.font = [[VBStyle style] nameProductFont];
    [self.view addSubview:_titleProductLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.contentMode = UIViewContentModeTop;
    _priceLabel.numberOfLines = 1;
    _priceLabel.textColor = [[VBStyle style] amountProductColor];
    _priceLabel.font = [[VBStyle style] amountProductFont];
    [self.view addSubview:_priceLabel];
    
    NSMutableAttributedString* sumAttributedString = [[NSMutableAttributedString alloc]
                                                      initWithAttributedString:[[NSString stringWithFormat:@"%ld",(long)product.price.cents] fromCurrencyCents:product.price.currency]];
    
    NSMutableAttributedString* sumSubString = [[NSMutableAttributedString alloc] initWithString:@""];
    [sumSubString addAttribute:NSFontAttributeName value:[[VBStyle style] nameProductFont] range:NSMakeRange(0, sumSubString.length)];
    [sumAttributedString appendAttributedString:sumSubString];
    _priceLabel.attributedText = sumAttributedString;

    _onOrder = [[VBAddToCartButton alloc] init];
    [_onOrder.titleLabel setFont:[UIFont systemFontOfSize:18]];
    _onOrder.layer.cornerRadius = 4;
    _onOrder.layer.borderWidth = 1;
    _onOrder.layer.masksToBounds = YES;
    [_onOrder addTarget:self action:@selector(onOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_onOrder];
    
    _textField = [[UITextView alloc] init];
    _textField.editable = NO;
    _textField.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _textField.text = product.title;
    _textField.contentMode = UIViewContentModeTop;
    [self.view addSubview:_textField];
    
    [self loadSmallStyle];
}

-(void)loadSmallStyle
{
    [_imageView setFrame:CGRectMake(20, 20, 100, 100)];
    [_titleProductLabel setFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 10, CGRectGetMinY(_imageView.frame), 180, 40)];
    [_priceLabel setFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 10, CGRectGetMaxY(_titleProductLabel.frame) + 5, 180, 20)];
    [_onOrder setFrame:CGRectMake(20, CGRectGetMaxY(_imageView.frame) + 20, CGRectGetWidth(self.view.frame) - 20 * 2, 40)];
    [_onOrder setAmount:[NSNumber numberWithDouble:product.price.cents] currency:product.price.currency];
    [_textField setFrame:CGRectMake(CGRectGetMinX(_onOrder.frame),
                                   CGRectGetMaxY(_onOrder.frame) + 10,
                                   CGRectGetWidth(self.view.bounds) - CGRectGetMinX(_onOrder.frame) * 2,
                                    CGRectGetHeight(self.view.bounds) - (CGRectGetMaxY(_onOrder.frame) + 10) - 44 - 70)];
    if ([appDelegate.cart countProductInCartWithIdProduct:product.idProduct] == 0) {
        [_onOrder goodNotCart];
    }
    else
        [_onOrder goodsCountInCart:[NSNumber numberWithLong:[appDelegate.cart countProductInCartWithIdProduct:product.idProduct]]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateOnBuy];
    self.title = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.title = product.title;
}

-(void)updateOnBuy
{
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    _onBuy.userInteractionEnabled = [appDelegate.cart getItemsCount] > 0 ? YES : NO;
}

-(void)onDetailImage
{
    [self performSegueWithIdentifier:@"segDetailImage" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onOrder:(id)sender {
    NSUInteger countProducts = [appDelegate.cart countProductInCartWithIdProduct:_idProduct];
    if (countProducts == 0) {
        [appDelegate.cart addIdProduct:_idProduct count:1];
        [_onOrder goodsCountInCart:@1];
        //[self initData];
        [self updateOnBuy];
    }
    else {
        [picker selectIndexes:@[[NSNumber numberWithInteger:[appDelegate.cart countProductInCartWithIdProduct:product.idProduct]]] animated:YES];
        [picker showInViewController:self];
    }
}

#pragma mark IQActionSheetPickerDelegate

- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles;
{
    NSInteger indexOfArray = [appDelegate.dataArrayForPicker indexOfObject:titles.firstObject];
    
    if (indexOfArray == 0) {
        //удаляем товар из заказа
        [appDelegate.cart addIdProduct:_idProduct count:0];
        [_onOrder goodNotCart];
    }
    else {
        //меняем количество товаров для заказа
        [appDelegate.cart addIdProduct:_idProduct count:indexOfArray];
        [_onOrder goodsCountInCart:[NSNumber numberWithLong:indexOfArray]];
    }
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    
    //[self initData];
    [self updateOnBuy];
}

-(void)onBuyAction
{
    [self performSegueWithIdentifier:@"segBuy" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segDetailImage"]) {
        DetailImageVC* destination = [segue destinationViewController];
        destination.imageUrl = product.image.mobile_url;
    }
    if ([segue.identifier isEqualToString:@"segBuy"]) {
        
    }
}

@end
