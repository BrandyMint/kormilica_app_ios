//
//  MoneyTest.m
//  Kormilica
//
//  Created by Viktor Bespalov on 16/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Money.h"

@interface MoneyTest : XCTestCase
{
    Money* money;
}
@end

@implementation MoneyTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    money = [[Money alloc] initWithCents:100 currency:@"RUB"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    money = nil;
}

- (void)testIsEqualToMoney
{
    Money* myMoney = [[Money alloc] initWithCents:100 currency:@"RUB"];
    
    XCTAssertTrue([money isEqualToMoney:myMoney], @"сравнение моделей money");
}

- (void)testIsNotEqualCentsToMoney
{
    Money* myMoney = [[Money alloc] initWithCents:200 currency:@"RUB"];
    
    XCTAssertFalse([money isEqualToMoney:myMoney], @"разные цены");
}

- (void)testIsNotEqualCurrencyToMoney
{
    Money* myMoney = [[Money alloc] initWithCents:100 currency:@"USD"];
    
    XCTAssertFalse([money isEqualToMoney:myMoney], @"разная валюта");
}

@end
