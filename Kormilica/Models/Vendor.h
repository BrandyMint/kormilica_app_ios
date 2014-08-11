//
//  Vendor.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.h"
#import "City.h"

@interface Vendor : NSObject

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) City* city;
@property (nonatomic, strong) NSString* updated_at;
@property (nonatomic, strong) NSString* mobile_logo_url;
@property (nonatomic, strong) NSString* mobile_title;
@property (nonatomic, strong) NSString* mobile_subject;
@property (nonatomic, strong) NSString* mobile_description;
@property (nonatomic, strong) NSString* mobile_footer;
@property (nonatomic, strong) NSString* mobile_delivery;
@property (nonatomic, strong) NSString* mobile_empty_cart_alert;
@property (nonatomic, strong) NSString* mobile_minimal_alert;
@property (nonatomic, strong) NSString* currency;
@property (nonatomic, assign) BOOL is_demo;
@property (nonatomic, strong) Money* minimal_price;
@property (nonatomic, strong) Money* delivery_price;

@end

/*
"key": "467abe2e7d33e6455fe905e879fd36be",
"name": "Демо Пончики",
"phone": "+7 (905) 198-11-71",
"city": "Чебоксары",
"updated_at": "2014-06-05T11:09:06.394+04:00",
"mobile_logo_url": "http://aydamarket.ru/uploads/vendor/mobile_logo/2/mob_logo.png",
"mobile_title": "Кормилица<br>демо",
"mobile_subject": "Кормилица-доставка (демо)",
"mobile_description": "Комплекс приема онлайн-заказов через интернет и мобильные приложения.\r\n\r\n<ul>\r\n<li>Возможность принимать online-заказы</li>\r\n<li>Мгновенное обновление витрины (меню) на всех платформах (что очень удобно при проведении акций и скидок)<li>\r\n<li>Единый дизайн для всех платформ</li>\r\n<li>Техническую поддержку всех платформ (обновление ПО)</li>\r\n<li>Автоматизированная обработка, формирования и уведомления по заказам.</li>\r\n<li>Полную статистику продаж (по просмотрам меню, по среднему чеку, количеству и времени заказов и т.д.)</li\r\n</ul>\r\n\r\n<p>Для кого этот сервис:</p>\r\n\r\n<ul>\r\n<li>Кафе, баров, ресторанов </li>\r\n<li>Служб  доставки</li>\r\n<li>Розничных магазинов.</li>\r\n<li>А также для любого  другого бизнеса, который хочет выйти на рынок мобильных продаж.</li>\r\n</ul>",
"mobile_footer": "Выберите блюдо на заказ",
"mobile_delivery": "Доставка бесплатно от 500 руб.",
"mobile_empty_cart_alert": "Выберите из списка блюдо на заказ.",
"mobile_minimal_alert": "Минимальный заказ от 500 р.",
"minimal_price": {
    "cents": 50000,
    "currency": "RUB"
},
"delivery_price": {
    "cents": 0,
    "currency": "RUB"
},
"currency": "RUB",
"is_demo": true
*/