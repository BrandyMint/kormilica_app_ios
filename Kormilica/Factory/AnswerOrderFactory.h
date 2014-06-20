//
//  AnswerOrderFactory.h
//  Kormilica
//
//  Created by Viktor Bespalov on 20/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyMapping.h"
#import "AnswerOrder.h"

@interface AnswerOrderFactory : NSObject

+ (EKObjectMapping*) answerOrderMapping;

@end
