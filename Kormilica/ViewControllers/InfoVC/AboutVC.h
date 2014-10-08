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
{
    CGFloat heightWebView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
