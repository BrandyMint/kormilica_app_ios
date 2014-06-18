//
//  BacketTest.m
//  Kormilica
//
//  Created by Viktor Bespalov on 11/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Cart.h"

@interface CartTest : XCTestCase
{
    Cart* cart;
    Product* product1;
    Money* price1;
    
    Product* product2;
    Money* price2;
}
@end

@implementation CartTest

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
    
    price2= [[Money alloc] initWithCents:200 currency:@"RUB"];
    product2 = [Product new];
    product2.title = @"Пончик2";
    product2.price = price2;
    product2.idProduct = 2;
}

- (void)testTotalPriceIsZero
{
    XCTAssert(cart.getTotalPrice.cents == 0, @"Сумма товаров в пустой корзине должна быть равна нулю");
    XCTAssert(cart.getItemsCount == 0, @"Количество товаров должно быть равно нулю");
}

- (void)testAddOneProduct
{
    [cart addProduct:product1 count:1];
    
    XCTAssert(cart.getTotalPrice.cents == 100, @"Сумма товаров в пустой корзине должна быть равна цене добавленного товара");
    XCTAssert(cart.getItemsCount == 1, @"Количество товаров должно быть равно 1");
}

- (void)testAddAnotherProduct
{
    [cart addProduct:product1 count:1];
    [cart addProduct:product2 count:2];
    
    XCTAssert(cart.getTotalPrice.cents == 500, @"Сумма товаров в пустой корзине должна быть равна ценам добавленных товара");
    XCTAssert(cart.getItemsCount == 2, @"Количество товаров должно быть равно 2");
}

-(void)testGetItems
{
    XCTAssertNotNil(cart.getItems, @"Возвращает список item-ов");
}

// Если добавляем уже существующий товар, то увеличивается счетчик у существующего, а количество item-ов не меняется
-(void)testEditCountProduct
{
    [cart addProduct:product1 count:1];
    [cart addProduct:product1 count:3];
    
    XCTAssert(cart.getTotalPrice.cents == 300, @"Сумма товаров в пустой корзине должна быть равна ценам добавленных товара");
    XCTAssert(cart.getItemsCount == 1, @"Количество товаров должно быть равно 1");
}

// Удалить товар
// Изменить количество товаров (product, count), Если count=0 то удалять
-(void)testDeleteProductByZeroCount
{
    [cart addProduct:product2 count:1];
    
    [cart addProduct:product1 count:12];
    [cart addProduct:product1 count:0];
    
    XCTAssert(cart.getTotalPrice.cents == 200, @"Сумма товаров в пустой корзине должна быть равна ценам добавленных товара");
    XCTAssert(cart.getItemsCount == 1, @"Количество товаров должно быть равно 1");
}

// Изменить количество товаров (product, count), Если count=0 то удалять
-(void)testDeleteNotExistenProductByZeroCount
{
    [cart addProduct:product1 count:0];
    
    XCTAssert(cart.getItemsCount == 0, @"Количество товаров должно быть равно 0");
}

-(void)testDeleteProduct
{
    [cart deleteProduct:product1];

    [cart addProduct:product1 count:12];
    [cart deleteProduct:product1];

    XCTAssert(cart.getTotalPrice.cents == 0, @"Сумма товаров остается нулевой");
    XCTAssert(cart.getItemsCount == 0, @"Товаров в корзине нет");
}

// Проверять что возвращается правильный список товаров
-(void)testGetItems1 {
    XCTAssert(cart.items.count == 0, @"Изначально в корзине нет товаров");
    
    [cart addProduct:product1 count:12];
    XCTAssert(cart.items.count == 1, @"Добавился один товар");
    
    OrderItem *item = [cart.items firstObject];
    XCTAssert(item.count == 12, @"Количество верное");
    XCTAssert(item.product.idProduct == product1.idProduct, @"Товар верный");
}

// Очистить все товары
-(void)testRemoveAllProduct
{
    [cart addProduct:product2 count:1];
    [cart addProduct:product1 count:11];
    
    [cart removeAllProduct];
    
    XCTAssert(cart.getTotalPrice.cents == 0, @"Сумма товаров в пустой корзине должна быть равна ценам добавленных товара");
    XCTAssert(cart.getItemsCount == 0, @"Количество товаров должно быть равно 0");
}

// Сохранение и восстановление корзины
-(void)testSaveAllProduct
{
    [cart addProduct:product1 count:1];
    [cart saveCart];
    
    Cart* loadCart = [cart loadCart];
    
    XCTAssert(loadCart.getTotalPrice.cents == 100, @"Сумма всех товаров в сохраненной корзине равно 100");
    XCTAssert(loadCart.getItemsCount == 1, @"Количество сохраненных товаров должно быть равно 1");
}

-(void)testAllowedOrder
{
    Vendor* vendor = [[Vendor alloc] init];
    Money* minimal_price = [[Money alloc] initWithCents:500 currency:@"RUB"];
    vendor.minimal_price = minimal_price;
    cart.vendor = vendor;
    
    XCTAssertFalse(cart.isAllowedOrder, @"оформление заказа невозможно пока сумма в корзине не превысит 500");
    
    [cart addProduct:product1 count:5];
    XCTAssertTrue(cart.isAllowedOrder, @"оформление заказа невозможно пока сумма в корзине не превысит 500");
}

// Добавили в корзину товар
// Изменили цену товара в базе
// У корзины вызвали resetTotal
// Общая стоимость корзины изменилась.
-(void)testPriceChange
{
    [cart addProduct:product1 count:1];
    
    XCTAssert(cart.getTotalPrice.cents == 100, @"Сумма товаров в пустой корзине должна быть равна цене добавленного товара");
    
    Money* newPrice = [[Money alloc] initWithCents:50 currency:@"RUB"];
    product1.price = newPrice;
    
    XCTAssert(cart.getTotalPrice.cents == 50, @"Сумма товаров в пустой корзине должна быть равна цене добавленного товара");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    cart = nil;
    product1 = nil;
    price1 = nil;
    
    product2 = nil;
    price2 = nil;
}

@end
