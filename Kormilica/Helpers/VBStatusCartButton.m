//
//  VBStatusCardButton.m
//  Kormilica
//
//  Created by bespalown on 17/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "VBStatusCartButton.h"
#import "UIImage+Overlay.h"


@implementation VBStatusCartButton
{
    UIImageView *cartImageView;
    UIImageView *circleImageView;
    
    UILabel *countLabel;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self initDefault];
    }
    return self;
}

-(id)init
{
    if (self == [super init]) {
        [self initDefault];
    }
    return self;
}

-(void)layoutSubviews
{
    
}

-(void)initDefault
{
    [self setFrame:CGRectMake(0, 0, 60, 22)];
    [self setTitle:nil forState:UIControlStateNormal];
    
    _color = [[VBStyle sharedInstance] navigationBarFontColor];
    
    cartImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"cart"]
                            imageWithColor:[UIColor whiteColor]]];
    
    circleImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"circle"]
                            imageWithColor:[UIColor whiteColor]]];
    [cartImageView setFrame:CGRectMake(0,
                                       0,
                                       CGRectGetHeight(self.frame),
                                       CGRectGetHeight(self.frame))];
    [circleImageView setFrame:CGRectMake(CGRectGetMidX(self.bounds) - 2,
                                         0 - 2,
                                         CGRectGetHeight(self.frame) + 4,
                                         CGRectGetHeight(self.frame) + 4)];
    circleImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    countLabel = [[UILabel alloc] initWithFrame:circleImageView.bounds];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000];
    countLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [circleImageView addSubview:countLabel];

    [self setCountProductInCard:0];
}

-(void)setCountProductInCard:(NSUInteger)theCount;
{
    [circleImageView removeFromSuperview];
    [cartImageView removeFromSuperview];
    
    if (theCount == 0) {
        countLabel.text = nil;
        CGRect rect = cartImageView.frame;
        if  (rect.origin.x == 0) {
            rect.origin.x += CGRectGetMidX(self.bounds);
        }
        [cartImageView setFrame:rect];
        [self addSubview:cartImageView];
    }
    else {
        countLabel.text = [NSString stringWithFormat:@"%ld",(long)theCount];
        
        [cartImageView setFrame:CGRectMake(0,
                                           0,
                                           CGRectGetHeight(self.frame),
                                           CGRectGetHeight(self.frame))];
        [circleImageView setFrame:CGRectMake(CGRectGetMidX(self.bounds) - 2,
                                             0 - 2,
                                             CGRectGetHeight(self.frame) + 4,
                                             CGRectGetHeight(self.frame) + 4)];
        
        [self addSubview:cartImageView];
        [self addSubview:circleImageView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
