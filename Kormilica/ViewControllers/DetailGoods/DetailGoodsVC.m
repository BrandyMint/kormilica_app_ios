//
//  DetailGoodsVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "DetailGoodsVC.h"
#import "IQActionSheetPicker.h"
#import "DetailImageVC.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+NUI.h"
#import "UILabel+NUI.h"
#import "UITextView+NUI.h"
#import "NSString+Currency.h"

@interface DetailGoodsVC () <IQActionSheetPickerDelegate, onBuyViewDelegate>
{
    Product* product;
}
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
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDetailImage)];
    [_logo addGestureRecognizer:tap];
    _logo.userInteractionEnabled = YES;
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateOnBuy];
}

-(void)updateOnBuy
{
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
}

-(void)onDetailImage
{
    [self performSegueWithIdentifier:@"segDetailImage" sender:self];
}

-(void)initData
{
    [_logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:nil];
    
    _titleProduct.text = product.title;
    _titleProduct.contentMode = UIViewContentModeTop;
    [_titleProduct setNuiClass: @"Label:TitleProductCell"];
    
    //_price.text = [NSString stringWithFormat:@"%d %@ /шт.",product.price.cents/100, product.price.currency];
    NSMutableAttributedString* sumAttributedString = [[NSMutableAttributedString alloc]
                                                      initWithAttributedString:[[NSString stringWithFormat:@"%d",product.price.cents] fromCurrencyCents:product.price.currency]];
    
    NSAttributedString* sumSubString = [[NSAttributedString alloc] initWithString:@" / шт."];
    [sumAttributedString appendAttributedString:sumSubString];
    _price.attributedText = sumAttributedString;
    
    _price.contentMode = UIViewContentModeTop;
    [_price setNuiClass: @"Label:PriceProductCell"];
    
    [_onOrder.titleLabel setFont:[UIFont systemFontOfSize:18]];
    _onOrder.layer.cornerRadius = 4;
    _onOrder.layer.borderWidth = 1;
    _onOrder.layer.masksToBounds = YES;

    if ([appDelegate.cart countProductInCartWithIdProduct:_idProduct] == 0) {
        [_onOrder setTitle:@"Добавить заказ" forState:UIControlStateNormal];
        [NUIRenderer renderButton:_onOrder withClass:@"ButtonAddToCart:ButtonAddToCartUnSelected:Detailed"];
    }
    else {
        [_onOrder setTitle:[NSString stringWithFormat:@"В заказе: %d шт.",[appDelegate.cart countProductInCartWithIdProduct:_idProduct]] forState:UIControlStateNormal];
        [NUIRenderer renderButton:_onOrder withClass:@"ButtonAddToCart:ButtonAddToCartSelected:Detailed"];
    }

    _descriptions.text = product.title;
    _descriptions.scrollEnabled = NO;
    _descriptions.editable = NO;
    _descriptions.contentMode = UIViewContentModeTop;
    [_descriptions setNuiClass:@"TextViewDescriptionProduct"];
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
        [self initData];
        [self updateOnBuy];
    }
    else {
        IQActionSheetPicker *picker = [[IQActionSheetPicker alloc] initWithTitle:@"Сколько заказать?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        [picker setTag:1];
        picker.backgroundColor = COLOR_GRAY;
        
        NSMutableArray* arr = [NSMutableArray new];
        [arr addObject:@"Удалить из заказа"];
        for (int i = 1; i < 26; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [picker setTitlesForComponenets:[NSArray arrayWithObjects:arr, nil]];
        [picker setDefaultValues:@[[NSString stringWithFormat:@"%d",[appDelegate.cart countProductInCartWithIdProduct:_idProduct]]]];
        [picker showInView:self.view];
    }
}

#pragma mark IQActionSheetPickerDelegate

-(void)actionSheetPickerView:(IQActionSheetPicker *)pickerView didSelectTitles:(NSArray *)titles didSelectIndexes:(NSArray *)indexes
{
    if ([[indexes firstObject] integerValue] == 0) {
        //удаляем товар из заказа
        [appDelegate.cart addIdProduct:_idProduct count:0];
    }
    else {
        //меняем количество товаров для заказа
        [appDelegate.cart addIdProduct:_idProduct count:[[indexes firstObject] integerValue]];
    }
    [self initData];
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
