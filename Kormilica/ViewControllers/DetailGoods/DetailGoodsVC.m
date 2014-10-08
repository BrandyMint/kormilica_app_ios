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

@interface DetailGoodsVC () <IQActionSheetPickerViewDelegate, onBuyViewDelegate>
{
    Product* product;
    IQActionSheetPickerView *picker;
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
    
    picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Сколько заказать?" delegate:self];
    picker.backgroundColor = COLOR_GRAY;
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     appDelegate.dataArrayForPicker,
                                     nil]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateOnBuy];
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

-(void)initData
{
    [_logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:[UIImage imageNamed:@"typeImage.png"]];
    
    _titleProduct.text = product.title;
    _titleProduct.contentMode = UIViewContentModeTop;
    [NUIRenderer renderLabel:_titleProduct withClass:@"LabelDefault:TitleProductCell"];
    
    //_price.text = [NSString stringWithFormat:@"%d %@ /шт.",product.price.cents/100, product.price.currency];
    NSMutableAttributedString* sumAttributedString = [[NSMutableAttributedString alloc]
                                                      initWithAttributedString:[[NSString stringWithFormat:@"%d",product.price.cents] fromCurrencyCents:product.price.currency]];

    NSMutableAttributedString* sumSubString = [[NSMutableAttributedString alloc] initWithString:@" / шт."];
    [sumSubString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:14] range:NSMakeRange(0, sumSubString.length)];
    
    [sumAttributedString appendAttributedString:sumSubString];
    _price.attributedText = sumAttributedString;
    _price.contentMode = UIViewContentModeTop;
    
    [_onOrder.titleLabel setFont:[UIFont systemFontOfSize:18]];
    _onOrder.layer.cornerRadius = 4;
    _onOrder.layer.borderWidth = 1;
    _onOrder.layer.masksToBounds = YES;

    if ([appDelegate.cart countProductInCartWithIdProduct:_idProduct] == 0) {
        [_onOrder setTitle:@"Добавить в заказ" forState:UIControlStateNormal];
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
    }
    else {
        //меняем количество товаров для заказа
        [appDelegate.cart addIdProduct:_idProduct count:0];
    }
    [_onBuy isAllowed:[appDelegate.cart isAllowedOrderFromProducts:appDelegate.bundles.products] ? YES : NO];
    
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
