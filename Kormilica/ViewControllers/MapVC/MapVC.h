//
//  MapVC.h
//  Kormilica
//
//  Created by Viktor Bespalov on 10/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SVAnnotation.h"
#import "SVPulsingAnnotationView.h"

@interface MapVC : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
