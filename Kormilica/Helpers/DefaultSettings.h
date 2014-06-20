//
//  DefaultSettings.h
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#define BUNDLES_API @"http://api.kormilica.info:80/v1/bundles.json"
#define ORDER_API @"http://api.kormilica.info:80/v1/orders.json"
#define VENDOR_KEY @"467abe2e7d33e6455fe905e879fd36be"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )
#define IS_IOS7 floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1

#define COLOR_ALPHA [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define COLOR_ORANGE [UIColor colorWithRed:242.0f/255.0f green:121.0f/255.0f blue:90.0f/255.0f alpha:1]
#define COLOR_SKY [UIColor colorWithRed:114.0f/255.0f green:186.0f/255.0f blue:182.0f/255.0f alpha:1]
#define COLOR_GRAY [UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]
#define COLOR_BLUE_ [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1]
#define COLOR_GREEN_ [UIColor colorWithRed:122.0f/255.0f green:201.0f/255.0f blue:67.0f/255.0f alpha:1]
#define COLOR_RED_ [UIColor colorWithRed:237.0f/255.0f green:28.0f/255.0f blue:36.0f/255.0f alpha:1]