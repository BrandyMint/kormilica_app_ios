//
//  Managers.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "Managers.h"
#import "AFNetworking.h"
#import "Factory.h"
#import "AnswerOrderFactory.h"

@implementation Managers

- (void) getBundles:(void (^) (Bundles* bundles)) block  failBlock:(void (^) (NSException *exception)) blockException
{

    NSString* urlString = BUNDLES_API;
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [request addValue:VENDOR_KEY forHTTPHeaderField:@"X-Vendor-Key"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
         {
             
             Bundles* bundles = [EKMapper objectFromExternalRepresentation:JSON withMapping:[Factory bundlesMapping]];
             block(bundles);
         }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
         {
             NSString* errorString = [JSON objectForKey:@"error"];
             NSException *exception = [[NSException alloc] initWithName:errorString
                                                                 reason:nil
                                                               userInfo:nil];
             blockException(exception);
         }];
    [operation start];

}

-(void)getLocalBundles:(void (^) (Bundles* bundles))block
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DefaultData" ofType:@"json"];
    // Retrieve local JSON file called DefaultData.json

    NSError *error = nil; // This so that we can access the error if something goes wrong
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    // Load the file into an NSData object called JSONData
    
    NSError* errorDictinary;
    NSDictionary* JSON = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&errorDictinary];
    
    Bundles* bundles = [EKMapper objectFromExternalRepresentation:JSON withMapping:[Factory bundlesMapping]];
    
    block(bundles);
}

-(void)postOrder:(Order *)order block:(void(^) (AnswerOrder* answerOrder))block failBlock:(void (^) (NSException *exception)) blockException
{
    NSString* urlString = ORDER_API;
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSData* jsonData = [appDelegate.createOrderToJson getOrderDataWithOrder:order];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [request addValue:VENDOR_KEY forHTTPHeaderField:@"X-Vendor-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
         {
             AnswerOrder* answerOrder = [EKMapper objectFromExternalRepresentation:JSON withMapping:[AnswerOrderFactory answerOrderMapping]];
             block(answerOrder);
         }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
         {
             NSInteger code = [[JSON objectForKey:@"code"] integerValue];
             NSString* errorString = [JSON objectForKey:@"error"];
             NSException *exception = [[NSException alloc] initWithName:errorString
                                                                 reason:[NSString stringWithFormat:@"%d",code]
                                                               userInfo:nil];
             blockException(exception);
         }];
    [operation start];
}

@end
