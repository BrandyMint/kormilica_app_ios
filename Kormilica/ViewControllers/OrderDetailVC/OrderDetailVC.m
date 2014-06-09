//
//  OrderDetailVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 09/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "OrderDetailVC.h"
#import "SHSPhoneLibrary.h"
#import "AccessoriesOrderView.h"

@interface OrderDetailVC () <UITextFieldDelegate, AccessoriesOrderDelegate, UIAlertViewDelegate>
{
    CGFloat maxY;
    
    NSString* phone;
    NSString* city;
    NSString* address;
    
    AccessoriesOrderView* accessoriesOrderView;
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
    city =@"Чебоксары";

    NSArray* keyArray = @[@"Телефон",
                          @"Город",
                          @"Адрес доставки"];
    
    for (int i=0; i<keyArray.count; i++) {
        [self createStringForKey:[keyArray objectAtIndex:i] value:[keyArray objectAtIndex:i] tag:i+1];
    }
    
    accessoriesOrderView = [[AccessoriesOrderView alloc] initWithFrame:CGRectMake(0, maxY, CGRectGetWidth(self.view.frame), 50)];
    accessoriesOrderView.delegate = self;
    [self.view addSubview:accessoriesOrderView];
    
    [accessoriesOrderView view:fill];
}

-(void)createStringForKey:(NSString *)key value:(NSString *)value tag:(NSInteger)tag
{
    UILabel* keyLabel = [[UILabel alloc] init];
    keyLabel.frame = CGRectMake(20, maxY, 120, 20);
    keyLabel.textColor = [UIColor blackColor];
    keyLabel.text = key;
    keyLabel.font = [UIFont systemFontOfSize:14];
    keyLabel.userInteractionEnabled = YES;
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
    
    if (phone.length != 0 && address.length != 0) {
        [accessoriesOrderView view:deliver];
    }
    else {
        [accessoriesOrderView view:fill];
    }
}

#pragma mark AccessoriesOrderDelegate

-(void)onAccessoriesOrderAction
{
    [accessoriesOrderView view:sending];
}

-(void)onAccessoriesOrderSending
{
    [accessoriesOrderView view:deliver];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Спасибо! Ваш заказ принят. В ближайшее время мы свяжемся с вами"
                                                   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"segRootMenu" sender:self];
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
