//
//  AboutTextCell.m
//  Kormilica
//
//  Created by bespalown on 07/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutTextCell.h"
#import "UITextView+NUI.h"
#import "NSString-HTML.h"

@implementation AboutTextCell

-(void)layoutSubviews
{
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
    
    [_textView setNuiClass:@"TextViewDescriptionProduct"];
    
    _webView.scrollView.scrollEnabled = NO;
}

@end
