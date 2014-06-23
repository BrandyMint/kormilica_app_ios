//
//  FeedBackView.m
//  Kormilica
//
//  Created by Viktor Bespalov on 10/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "FeedBackView.h"
#import "UILabel+NUI.h"
#import "UIButton+NUI.h"

@implementation FeedBackView
{
    NSString* _telephoneNumber;
}

- (id)initWithFrame:(CGRect)frame telephoneNumber:(NSString *)telephoneNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 1)];
        topView.backgroundColor = COLOR_GRAY;
        [self addSubview:topView];
        
        UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame)-1, CGRectGetWidth(self.frame), 1)];
        bottomView.backgroundColor = COLOR_GRAY;
        [self addSubview:bottomView];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(frame), 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.text = @"Связяться с нами";
        label.backgroundColor = [UIColor clearColor];
        [label setNuiClass:@"Label"];
        [self addSubview:label];
        
        UILabel* telephone = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 200, 30)];
        telephone.font = [UIFont systemFontOfSize:20];
        telephone.textAlignment = NSTextAlignmentCenter;
        telephone.textColor = [UIColor blackColor];
        telephone.contentMode = UIViewContentModeCenter;
        telephone.text = telephoneNumber;
        telephone.backgroundColor = [UIColor clearColor];
        [telephone setNuiClass:@"Label:Telephone"];
        [self addSubview:telephone];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:CGRectMake(200, 50, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.masksToBounds = YES;
        [button setTitle:@"позвонить" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitleColor:COLOR_BLUE_ forState:UIControlStateNormal];
        button.layer.borderColor = COLOR_BLUE_.CGColor;
        [button addTarget:self action:@selector(onCall) forControlEvents:UIControlEventTouchUpInside];
        [button setNuiClass:@"ButtonOrderCell:ButtonInNotOrder"];
        [self addSubview:button];
    }
    return self;
}

-(void)onCall
{
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_telephoneNumber]]];
    } else {
        UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:nil message:@"Устройство не поддерживает эту функцию." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notPermitted show];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
