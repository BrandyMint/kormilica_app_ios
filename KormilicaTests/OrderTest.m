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
#import "CoreDataHelper.h"

@interface OrderTest : XCTestCase
{
    Cart* cart;
    Product* product1;
    Money* price1;
    Order* order;
    CoreDataHelper* coreDataHelper;
}
@end

@implementation OrderTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    coreDataHelper = [CoreDataHelper new];
    cart = [Cart new];
    
    price1 = [[Money alloc] initWithCents:100 currency:@"RUB"];
    product1 = [Product new];
    product1.title = @"Пончик1";
    product1.price = price1;
    product1.idProduct = 1;
    
    [cart addProduct:product1 count:1];
    
    order = [[Order alloc] initWithOrderItems:[cart getItems] total_price:[cart getTotalPrice]];
    order.address = @"город, улица, дом";
    order.telephone = @"+70000000000";
}

// Сформировать заказ из корзины. Order: items, total_price, address (город, улица, дом), telephon.
-(void)testOrder
{
    XCTAssert(order.total_price.cents == 100, @"Сумма всех товаров в заказе равно 100");
    XCTAssert(order.getItems.count == 1, @"Количество товаров в заказе 1");
}

// Тест на то, что при изменении данных продукта, данные продукта в заказе не меняются (цена и название)
-(void)testEditProduct
{
    //создали заказ
    OrderItem* item = [order.items firstObject];
    XCTAssertEqual(item.product.title, @"Пончик1", @"название продукта не должно меняться");
    XCTAssertTrue([item.product.price isEqualToMoney:price1], @"прайс не должен меняться");
    
    [order saveOrder];
    
    // доставешь из базы товар
    // меняешь у него цену
    // проверяшь что в заказе цена товара не изменилась

    Order* loadOrder = [order loadOrder];
    
    XCTAssert(loadOrder.total_price.cents == 100, @"Сумма всех товаров в заказе равно 100");
    XCTAssert(loadOrder.getItems.count == 1, @"Количество товаров в заказе 1");
    
    OrderItem* orderItem = [loadOrder.items firstObject];
    Product* orderProduct = orderItem.product;
    orderProduct.title = @"sos";
    orderProduct.price.cents = 99;
    orderProduct.price.currency = @"USD";
    
    XCTAssertTrue([orderItem.product.title isEqualToString:@"Пончик1"], @"название продукта не должно меняться");
    XCTAssertTrue([orderItem.product.price isEqualToMoney:price1], @"прайс не должен меняться");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    cart = nil;
    product1 = nil;
    price1 = nil;
    order = nil;
    coreDataHelper = nil;
}

@end
