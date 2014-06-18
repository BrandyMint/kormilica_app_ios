//
//  OrderTest.m
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Order.h"
#import "Cart.h"

@interface OrderTest : XCTestCase
{
    Cart* cart;
    Product* product1;
    Money* price1;
    Order* order;
}
@end

@implementation OrderTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    cart = [Cart new];
    
    price1 = [[Money alloc] initWithCents:100 currency:@"RUB"];
    product1 = [Product new];
    product1.title = @"Пончик1";
    product1.price = price1;
    product1.idProduct = 1;
    
    order = [Order new];
    order.address = @"город, улица, дом";
    order.telephone = @"+70000000000";
    
   
}

// Сформировать заказ из корзины. Order: items, total_price, address (город, улица, дом), telephon.
-(void)testOrder
{
    [cart addProduct:product1 count:1];
    
    [order setItems:[cart getItems]];
    
    [order setTotal_price:[cart getTotalPrice]];
    
    XCTAssert(order.getTotal_price.cents == 100, @"Сумма всех товаров в заказе равно 100");
    XCTAssert(order.getItems.count == 1, @"Количество товаров в заказе 1");
}

// Тест на то, что при изменении данных продукта, данные продукта в заказе не меняются (цена и название)
-(void)testEditProduct
{
    //создали заказ
    
    [cart addProduct:product1 count:1];
    
    [order setItems:[cart getItems]];
    [order setTotal_price:[cart getTotalPrice]];

    XCTAssert(order.getTotal_price.cents == 100, @"Сумма всех товаров в заказе равно 100");
    XCTAssert(order.getItems.count == 1, @"Количество товаров в заказе 1");
    
    Item* item = [order.items firstObject];
    XCTAssertEqual(item.product.title, @"Пончик1", @"название продукта не должно меняться");
    XCTAssertTrue([item.product.price isEqualToMoney:price1], @"прайс не должен меняться");
    
    // доставешь из базы товар
    // меняешь у него цену
    // проверяшь чо в заказе цена товара не изменилась
    
    //изменили название товара в заказе
    Money* money = [[Money alloc] initWithCents:99 currency:@"USD"];
    Product* product = [Product new];
    product.title = @"Пончик1_1_1";
    product.price = money;
    product.idProduct = 1;
    
    [cart addProduct:product count:1];
    [order setItems:[cart getItems]];
    
    XCTAssert(order.getTotal_price.cents == 100, @"Сумма всех товаров в заказе равно 100");
    XCTAssert(order.getItems.count == 1, @"Количество товаров в заказе 1");
    
    Item* item1 = [order.items firstObject];
    XCTAssertEqual(item1.product.title, @"Пончик1", @"название продукта не должно меняться");
    XCTAssertTrue([item1.product.price isEqualToMoney:price1], @"прайс не должен меняться");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    cart = nil;
    product1 = nil;
    price1 = nil;
    order = nil;
}

@end
