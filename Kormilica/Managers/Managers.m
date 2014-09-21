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

-(void)downloadCSS
{
    NSString* urlString = @"https://gist.githubusercontent.com/bespalown/d06bbcb690ab41e9751d/raw/dcc40cbaac18d235322e350f84dc93e53b7929f5/Kormilica.NUI.nss";
    
    NSURL  *url = [NSURL URLWithString:urlString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //сохранили в документы
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
        NSError *error;
        [responseString writeToFile:[documentsDirectory stringByAppendingPathComponent:@"Style.nss"]
                         atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        //прочли из документов
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* foofile = [documentsPath stringByAppendingPathComponent:@"Style.nss"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    [operation start];
    
}

@end
