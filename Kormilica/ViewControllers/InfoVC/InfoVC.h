//
//  InfoVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterVC.h"

@class InfoVCD;
@protocol InfoVCDelegete
@optional
-(void)hidePopover;
@end

@interface InfoVC : MasterVC
@property (assign) id<InfoVCDelegete> delegate;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UITextView *descriptions;
@property (weak, nonatomic) IBOutlet UILabel *city;
- (IBAction)onUpdate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onUpdate;
- (IBAction)onHide:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onHide;

@end
