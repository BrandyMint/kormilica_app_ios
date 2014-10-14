//
//  MasterVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+RESideMenu.h"

@interface MasterVC : UIViewController
{
    AppDelegate* appDelegate;
}

-(void)showAlertException:(NSException*)exception;
-(void)networkActivity:(BOOL)activity;

@end
