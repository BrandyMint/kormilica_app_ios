//
//  InfoVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 05/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "InfoVC.h"
#import "NSString-HTML.h"

@interface InfoVC ()
{
    AppDelegate* appDelegate;
}
@end

@implementation InfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_ALPHA;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    UIColor* white = [UIColor whiteColor];
    UIFont* font = [UIFont systemFontOfSize:14];
    
    _header.textColor = white;
    _header.font = [UIFont systemFontOfSize:16];
    _header.textAlignment = NSTextAlignmentCenter;
    
    _descriptions.textColor = white;
    _descriptions.backgroundColor = [UIColor clearColor];
    _descriptions.font = font;
    _descriptions.editable = NO;
    
    _city.textColor = white;
    _city.font = font;
    _city.textAlignment = NSTextAlignmentCenter;
    
    _onUpdate.backgroundColor = [UIColor clearColor];
    [_onUpdate.titleLabel setFont:font];
    [_onUpdate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _onHide.backgroundColor = COLOR_ORANGE;
    [_onHide setTitle:@"Ok" forState:UIControlStateNormal];
    [_onHide.titleLabel setFont:font];
    [_onHide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self updateText];
}

-(void)updateText
{
    NSString* date = [appDelegate.convertTime iso8601_to_ddMMYYYY:appDelegate.bundles.vendor.updated_at];
    
    _header.text = appDelegate.bundles.vendor.mobile_subject;
    _descriptions.text = [appDelegate.bundles.vendor.mobile_description kv_stripHTMLCharacterEntities];
    _city.text = appDelegate.bundles.vendor.city;
    [_onUpdate setTitle:[NSString stringWithFormat:@"Последнее обновление от %@", date] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onHide:(id)sender {
    [_delegate hidePopover];
}

- (IBAction)onUpdate:(id)sender {
    [appDelegate.managers getBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        [self updateText];
    } failBlock:^(NSException * exception) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:exception.name message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

@end
