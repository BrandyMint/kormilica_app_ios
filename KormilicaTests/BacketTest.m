//
//  BacketTest.m
//  Kormilica
//
//  Created by Viktor Bespalov on 11/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MasterVC.h"
#import "Managers.h"

@interface BacketTest : XCTestCase
{
    MasterVC* masterVC;
}
@end

@implementation BacketTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    masterVC = [MasterVC new];
    [masterVC view];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    masterVC = nil;
}

-(void)testNilBacket
{
    [masterVC setCountProduct:0 idProduct:8];
    [masterVC setCountProduct:0 idProduct:13];
    XCTAssert([masterVC getPriceOrder] == 0, @"Корзина не пуста");
}

-(void)testAddIdProduct__13 //убираем товар с id 13
{
    [masterVC setCountProduct:0 idProduct:13];
    XCTAssert([masterVC getPriceOrder] == 10, @"Сумма товаров в карзине != 10 руб");
}

-(void)testAddIdProduct_8   //10 руб
{
    [masterVC setCountProduct:1 idProduct:8];
    XCTAssert([masterVC getPriceOrder] == 43, @"Сумма товаров в карзине != 43 руб");
}

-(void)testAddIdProduct_13   //33 руб
{
    [masterVC setCountProduct:1 idProduct:13];
    XCTAssert([masterVC getPriceOrder] == 33, @"Сумма товаров в карзине != 33 руб");
}

-(void)testCountProduct
{
    Managers* managers = [Managers new];
    [managers getLocalBundles:^(Bundles* bundles){
        NSInteger count = 0;
        count = bundles.products.count;
        XCTAssert(count == 13, @"count !13");
    }];
}

//проверяем корзину
//1 сумма = 0
//2 добавили продукт, сумма 100
//3 добавили продукт, сумма 200
//4 убрали продукт, сумма <`

@end
