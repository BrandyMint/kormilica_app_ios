//
//  DetailImageVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 10/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImageVC : UIViewController
//public
@property (nonatomic, strong) NSString* imageUrl;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
