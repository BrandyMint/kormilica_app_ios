//
//  InfoVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterVC.h"


@interface AboutVC : MasterVC
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *subHeader;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *onCall;
- (IBAction)onCall:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *onAddress;
- (IBAction)onAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shippingPayment;

@property (weak, nonatomic) IBOutlet UITextView *descriptions;
@property (weak, nonatomic) IBOutlet UILabel *city;
- (IBAction)onUpdate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onUpdate;


@end
