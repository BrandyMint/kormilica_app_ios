//
//  Categories.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categories : NSObject

@property (nonatomic, assign) NSInteger idCategories;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* updated_at;
@property (nonatomic, assign) NSInteger position;

@end

/*
"id": 1,
"name": "Пончики",
"updated_at": "2014-03-28T11:39:33.333+04:00",
"position": 0
*/