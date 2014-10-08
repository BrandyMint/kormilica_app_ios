//
//  MasterVC.m
//  Kormilica
//
//  Created by Viktor Bespalov on 06/06/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "MasterVC.h"
#import "MBProgressHUD.h"

@interface MasterVC ()

@end

@implementation MasterVC

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
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Назад" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)networkActivity:(BOOL)activity
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = activity;
    if (activity)
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    else
        [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)showAlertException:(NSException*)exception
{
    [self networkActivity:NO];
    if (exception) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:exception.name
                                                        message:exception.reason
                                                       delegate:Nil cancelButtonTitle:NSLocalizedString(@"Ок", nil) otherButtonTitles:Nil, nil];
        [alert show];
    }
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

@end
