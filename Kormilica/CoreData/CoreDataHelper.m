//
//  CoreDataHelper.m
//  Kormilica
//
//  Created by Viktor Bespalov on 18/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>

@implementation CoreDataHelper

-(void)saveOrder:(Order *)order
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];

    OrderCD* orderCD = [NSEntityDescription insertNewObjectForEntityForName:@"OrderCD" inManagedObjectContext:managedObjectContext];
    orderCD.telephone = order.telephone;
    orderCD.address = order.address;
    [orderCD addItems:(NSSet *)order.items];
}

-(OrderCD *)getOrder{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"OrderCD" inManagedObjectContext:managedObjectContext]];
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    if (results.count != 0) {
        return [results firstObject];
    }
    return nil;
}

-(void)deleteOrder
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"OrderCD"];
    NSArray* result = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    if (result.count != 0) {
        for (id backet in result) {
            [managedObjectContext deleteObject:backet];
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *managedObjectContext = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        managedObjectContext = [delegate managedObjectContext];
    }
    return managedObjectContext;
}

@end
