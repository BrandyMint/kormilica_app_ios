//
//  DetailGoodsVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "DetailGoodsVC.h"
#import "IQActionSheetPicker.h"

@interface DetailGoodsVC () <IQActionSheetPickerDelegate>
{
    AppDelegate* appDelegate;
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
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    for (Product* product_ in appDelegate.bundles.products) {
        if (product_.idProduct == _idProduct) {
            product = product_;
        }
    }
    [self initData];
}

-(void)initData
{
    [_logo setImageWithURL:[NSURL URLWithString:product.image.mobile_url] placeholderImage:nil];
    UIFont* font = [UIFont systemFontOfSize:14];
    
    _titleProduct.text = product.title;
    _titleProduct.textColor = [UIColor blackColor];
    _titleProduct.font = font;
    _titleProduct.contentMode = UIViewContentModeTop;
    
    _price.text = [NSString stringWithFormat:@"%d %@ /шт.",product.price.cents, product.price.currency];
    _price.textColor = [UIColor blackColor];
    _price.font = font;
    _price.contentMode = UIViewContentModeTop;
    
    [_onOrder.titleLabel setFont:[UIFont systemFontOfSize:18]];
    _onOrder.layer.cornerRadius = 4;
    _onOrder.layer.borderWidth = 1;
    _onOrder.layer.masksToBounds = YES;
    
    if (product.count == 0) {
        [_onOrder setTitle:@"Добавить заказ" forState:UIControlStateNormal];
        [_onOrder setBackgroundColor:[UIColor clearColor]];
        [_onOrder setTitleColor:COLOR_BLUE_ forState:UIControlStateNormal];
        _onOrder.layer.borderColor = COLOR_BLUE_.CGColor;
    }
    else {
        [_onOrder setTitle:[NSString stringWithFormat:@"В заказе: %d шт.",product.count] forState:UIControlStateNormal];
        [_onOrder setBackgroundColor:COLOR_GREEN_];
        [_onOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _onOrder.layer.borderColor = COLOR_GREEN_.CGColor;
    }
    
    _descriptions.text = product.title;
    _descriptions.scrollEnabled = NO;
    _descriptions.editable = NO;
    _descriptions.textColor = [UIColor blackColor];
    _descriptions.font = font;
    _descriptions.contentMode = UIViewContentModeTop;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onOrder:(id)sender {
    IQActionSheetPicker *picker = [[IQActionSheetPicker alloc] initWithTitle:@"Сколько заказать?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:1];
    picker.backgroundColor = COLOR_GRAY;
    
    NSMutableArray* arr = [NSMutableArray new];
    [arr addObject:@"Удалить из заказа"];
    for (int i = 1; i < 26; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:arr, nil]];
    [picker showInView:self.view];
}

#pragma mark IQActionSheetPickerDelegate

-(void)actionSheetPickerView:(IQActionSheetPicker *)pickerView didSelectTitles:(NSArray *)titles didSelectIndexes:(NSArray *)indexes
{
    if ([[indexes firstObject] integerValue] == 0) {
        //удаляем товар из заказа
        [self setCountProduct:0 idProduct:_idProduct];
    }
    else {
        //меняем количество товаров для заказа
        [self setCountProduct:[[indexes firstObject] integerValue] idProduct:_idProduct];
    }
    [self initData];
}

-(void)setCountProduct:(NSInteger)count idProduct:(NSInteger )idProduct
{
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:appDelegate.bundles.products];
    for (int i = 0; i < arr.count; i++) {
        Product* productArr = [arr objectAtIndex:i];
        if (productArr.idProduct == idProduct) {
            productArr.count = count;
            [arr replaceObjectAtIndex:i withObject:productArr];
        }
    }
    appDelegate.bundles.products = arr;
}

@end
