//
//  RootVC.m
//  Kormilica
//
//  Created by bespalown on 13/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "RootVC.h"
#import "UIImage+Overlay.h"

@implementation RootVC

- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.0;
    self.contentViewShadowRadius = 0;
    self.contentViewShadowEnabled = YES;
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    //self.rightMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rightMenuViewController"];
    //self.backgroundImage = [UIImage imageNamed:@"menuBackground"];
    self.delegate = self;
    
    self.contentViewScaleValue = 0.8;
    self.contentViewInPortraitOffsetCenterX = 30;
    //self.contentViewInPortraitOffsetCenterY = CGRectGetMidY(self.view.frame)+57;
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"willShowMenuViewController" object:nil];
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


@end
