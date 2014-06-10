//
//  OrderDetailVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "OrderDetailVC.h"
#import "SHSPhoneLibrary.h"
#import "DeliveryOrderView.h"
#import "FeedBackView.h"

@interface OrderDetailVC () <UITextFieldDelegate, DeliveryOrderDelegate, UIAlertViewDelegate>
{
    CGFloat maxY;
    
    NSString* phone;
    NSString* city;
    NSString* address;
    
    DeliveryOrderView* deliveryOrderView;
}
@end

@implementation OrderDetailVC

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
    maxY = IS_IOS7 ? 84 : 20;
    
    phone = address = @"";
    city = @"Чебоксары";

    NSArray* keyArray = @[@"Телефон",
                          @"Город",
                          @"Адрес доставки"];
    
    for (int i=0; i<keyArray.count; i++) {
        [self createStringForKey:[keyArray objectAtIndex:i] value:[keyArray objectAtIndex:i] tag:i+1];
    }
    
    deliveryOrderView = [[DeliveryOrderView alloc] initWithFrame:CGRectMake(0, maxY, CGRectGetWidth(self.view.frame), 50)];
    deliveryOrderView.delegate = self;
    [self.view addSubview:deliveryOrderView];
    
    [deliveryOrderView view:fill];
}

-(void)createStringForKey:(NSString *)key value:(NSString *)value tag:(NSInteger)tag
{
    UILabel* keyLabel = [[UILabel alloc] init];
    keyLabel.frame = CGRectMake(20, maxY, 120, 20);
    keyLabel.textColor = [UIColor blackColor];
    keyLabel.text = key;
    keyLabel.font = [UIFont systemFontOfSize:14];
    keyLabel.userInteractionEnabled = YES;
    keyLabel.tag = tag+10;
    [self.view addSubview:keyLabel];
    
    if (tag == 1)
    {
        SHSPhoneTextField* phoneTextField = [[SHSPhoneTextField alloc] initWithFrame:CGRectMake(140, CGRectGetMinY(keyLabel.frame), 170, keyLabel.frame.size.height)];
        [phoneTextField.formatter setDefaultOutputPattern:@"+7 ### ### ## ##"];
        phoneTextField.formatter.showFormatOnlyIfTextExist = NO;
        [phoneTextField setFormattedText:@""];
        phoneTextField.font = [UIFont systemFontOfSize:14];
        phoneTextField.delegate = self;
        phoneTextField.tag = 1;
        [self.view addSubview:phoneTextField];
        
        phoneTextField.textDidChangeBlock = ^(UITextField *textField) {
        };
    }
    else {
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(140, CGRectGetMinY(keyLabel.frame), 170, keyLabel.frame.size.height)];
        textField.text = @"";
        textField.font = [UIFont systemFontOfSize:15];
        textField.tag = tag;
        textField.delegate = self;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:textField];
        
        if (tag == 2)
        {
            textField.text = city;
            textField.textColor = COLOR_SKY;
            textField.enabled = NO;
        }
    }
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(keyLabel.frame) + 5, self.view.frame.size.width - 20, 1)];
    line.backgroundColor = COLOR_GRAY;
    line.tag = tag + 20;
    [self.view addSubview:line];
    
        maxY += 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
            //телефон
            phone = textField.text;
            break;
        case 2:
            //город
            city = textField.text;
            break;
        case 3:
            //адрес доставки
            address = textField.text;
            break;
        default:
            break;
    }
    
    if (phone.length == 16 && address.length != 0) {
        [deliveryOrderView view:deliver];
    }
    else {
        [deliveryOrderView view:fill];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    switch (textField.tag) {
        case 1:
            //телефон
            phone = textField.text;
            break;
        case 2:
            //город
            city = textField.text;
            break;
        case 3:
            //адрес доставки
            address = textField.text;
            break;
        default:
            break;
    }
    
    if (phone.length == 16 && address.length != 0) {
        [deliveryOrderView view:deliver];
    }
    else {
        [deliveryOrderView view:fill];
    }
    return YES;
}

#pragma mark DeliveryOrderDelegate

-(void)onDeliveryOrderAction
{
    [deliveryOrderView view:sending];
}

-(void)onDeliveryOrderBackToShop
{
    [self performSegueWithIdentifier:@"segRootMenu" sender:self];
}

-(void)onDeliveryOrderSending
{
    UILabel* error = [[UILabel alloc] initWithFrame:CGRectMake(0, IS_IOS7 ? 64 : 0, CGRectGetWidth(self.view.frame), 50)];
    error.textColor = [UIColor whiteColor];
    error.textAlignment = NSTextAlignmentCenter;
    error.contentMode = UIViewContentModeCenter;
    error.backgroundColor = COLOR_GREEN_;
    error.numberOfLines = 0;
    error.font = [UIFont systemFontOfSize:14];
    error.text = @"Заказ принят! Номер заказа: ****\n Ожидаемое время доставки - 14:30";
    [self.view addSubview:error];
    
    maxY = IS_IOS7 ? 84 + CGRectGetHeight(error.frame) : 20 + CGRectGetHeight(error.frame) ;
    
    for (int i = 1; i<4; i++) {
        UITextField* textfield = (UITextField *)[self.view viewWithTag:i];
        CGRect frameTextField = textfield.frame;
        frameTextField.origin.y = maxY;
        textfield.frame = frameTextField;
        textfield.enabled = NO;
        
        UILabel* label = (UILabel *)[self.view viewWithTag:i+10];
        CGRect frameLabel = label.frame;
        frameLabel.origin.y = maxY;
        label.frame = frameLabel;
        
        UIView* view = (UIView *)[self.view viewWithTag:i+20];
        CGRect frameView = view.frame;
        frameView.origin.y = CGRectGetMaxY(label.frame) + 5;
        view.frame = frameView;
        
        maxY += 40;
    }
    FeedBackView* feedBackView = [[FeedBackView alloc] initWithFrame:CGRectMake(0, maxY, CGRectGetWidth(self.view.frame), 90) telephoneNumber:@"+7 000 000 00 00"];
    [self.view addSubview:feedBackView];
    
    CGRect frameDeliveryOrderView = deliveryOrderView.frame;
    frameDeliveryOrderView.origin.y = CGRectGetMaxY(feedBackView.frame) + 10;
    deliveryOrderView.frame = frameDeliveryOrderView;
    
    [deliveryOrderView view:backToShop];
}

-(void)onDeliveryOrderFailSending
{
    UILabel* error = [[UILabel alloc] initWithFrame:CGRectMake(0, IS_IOS7 ? 64 : 0, CGRectGetWidth(self.view.frame), 50)];
    error.textColor = [UIColor whiteColor];
    error.textAlignment = NSTextAlignmentCenter;
    error.contentMode = UIViewContentModeCenter;
    error.backgroundColor = COLOR_RED_;
    error.numberOfLines = 0;
    error.font = [UIFont systemFontOfSize:14];
    error.text = @"Ваш заказ не принят:\n (причина отказа)";
    [self.view addSubview:error];
    
    maxY = IS_IOS7 ? 84 + CGRectGetHeight(error.frame) : 20 + CGRectGetHeight(error.frame) ;
    
    for (int i = 1; i<4; i++) {
        UITextField* textfield = (UITextField *)[self.view viewWithTag:i];
        CGRect frameTextField = textfield.frame;
        frameTextField.origin.y = maxY;
        textfield.frame = frameTextField;
        
        UILabel* label = (UILabel *)[self.view viewWithTag:i+10];
        CGRect frameLabel = label.frame;
        frameLabel.origin.y = maxY;
        label.frame = frameLabel;
        
        UIView* view = (UIView *)[self.view viewWithTag:i+20];
        CGRect frameView = view.frame;
        frameView.origin.y = CGRectGetMaxY(label.frame) + 5;
        view.frame = frameView;
        
        maxY += 40;
    }
    
    CGRect frameDeliveryOrderView = deliveryOrderView.frame;
    frameDeliveryOrderView.origin.y = maxY;
    deliveryOrderView.frame = frameDeliveryOrderView;
    
    [deliveryOrderView view:deliver];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segRootMenu"]) {
        
    }
}

@end
