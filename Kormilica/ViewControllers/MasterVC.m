//
//  MasterVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "MasterVC.h"

@interface MasterVC ()

@end

@implementation MasterVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

-(CGFloat)getPriceOrder
{
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:appDelegate.bundles.products];
    
    CGFloat sum = 0;
    for (int i = 0; i < arr.count; i++) {
        Product* product = [arr objectAtIndex:i];
        if (product.count != 0) {
            sum += product.count * product.price.cents/100;
        }
    }
    appDelegate.bundles.vendor.delivery_price.cents = sum;
    
    return sum;
}

-(NSArray *)getOrderArray
{
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:appDelegate.bundles.products];
    
    NSMutableArray* result = [NSMutableArray new];
    for (int i = 0; i < arr.count; i++) {
        Product* product = [arr objectAtIndex:i];
        
        if (product.count != 0) {
            [result addObject:product];
        }
    }
    return result;
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
