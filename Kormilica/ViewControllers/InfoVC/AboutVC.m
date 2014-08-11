//
//  InfoVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutVC.h"
#import "MapVC.h"
#import "UIImageView+AFNetworking.h"
#import "NSString-HTML.h"
#import "UIButton+NUI.h"
#import "UILabel+NUI.h"
#import "UITextView+NUI.h"
#import "UIView+NUI.h"

@interface AboutVC ()

@end

@implementation AboutVC

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
    [_header setNuiClass:@"Label:NameCompany"];
    
    _descriptions.editable = NO;
    [_descriptions setNuiClass:@"TextViewDescriptionProduct"];
    
    _city.textAlignment = NSTextAlignmentCenter;
    
    [_onCall setNuiClass:@"ButtonOrderCell:ButtonInNotOrder"];
    [_onAddress setNuiClass:@"ButtonOrderCell:ButtonInNotOrder"];
    [_shippingPayment setNuiClass:@"OrderFill"];
    [_onUpdate setNuiClass:@"ButtonLastUpdate"];
    
    [_shippingPayment setTitle:@"Доставка и оплата" forState:UIControlStateNormal];
    
    _subHeader.text = @"описание компании";
    _address.text = @"Крылова, 7";
    [_address setNuiClass:@"Label:AllSum"];
    [_onAddress setTitle:@"на карте" forState:UIControlStateNormal];
    
    [_phone setNuiClass:@"Label:Telephone"];
    _phone.text = @"+7 919 651 04 56";
    [_onCall setTitle:@"позвонить" forState:UIControlStateNormal];
    
    [_logo setImageWithURL:[NSURL URLWithString:appDelegate.bundles.vendor.mobile_logo_url] placeholderImage:[UIImage imageNamed:@""]];
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_phone.frame) + 7, CGRectGetWidth(self.view.frame), 1)];
    [line setNuiClass:@"BottomView"];
    [self.view addSubview:line];
    
    [self updateText];
}

-(void)updateText
{
    NSString* date = [appDelegate.convertTime iso8601_to_ddMMYYYY:appDelegate.bundles.vendor.updated_at];
    
    _header.text = appDelegate.bundles.vendor.mobile_subject;
    _descriptions.text = [appDelegate.bundles.vendor.mobile_description kv_stripHTMLCharacterEntities];
    _city.text = appDelegate.bundles.vendor.city.name;
    
    [_onUpdate setTitle:[NSString stringWithFormat:@"Последнее обновление от %@", date] forState:UIControlStateNormal];
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

- (IBAction)onHide:(id)sender {

}

- (IBAction)onUpdate:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [appDelegate.managers getBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        
        [self updateText];
        appDelegate.cart.vendor = bundles.vendor;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failBlock:^(NSException * exception) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:exception.name message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

- (IBAction)onCall:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"+79196510456"]]];
    } else {
        UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:nil message:@"Устройство не поддерживает эту функцию." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notPermitted show];
    }
}
- (IBAction)onAddress:(id)sender {
    [self performSegueWithIdentifier:@"segMap" sender:self];
}

@end
