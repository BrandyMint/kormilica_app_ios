//
//  AboutVC+TableView.m
//  Kormilica
//
//  Created by bespalown on 07/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "AboutVC+TableView.h"
#import "AboutLogoCell.h"
#import "AboutPhoneCell.h"
#import "AboutDeliveryCell.h"
#import "AboutTextCell.h"
#import "AboutOtherCell.h"
#import "NSString-HTML.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+Size.h"

@implementation AboutVC (TableView)

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 670;
            break;
        case 4:
            return 130;
            break;
        default:
            break;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier0 = @"AboutLogoCell";
    static NSString *CellIdentifier1 = @"AboutPhoneCell";
    //static NSString *CellIdentifier2 = @"AboutPhoneCell";
    //static NSString *CellIdentifier3 = @"AboutDeliveryCell";
    static NSString *CellIdentifier4 = @"AboutTextCell";
    static NSString *CellIdentifier5 = @"AboutOtherCell";
    
    if(indexPath.row == 0) {
        AboutLogoCell *cell = (AboutLogoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (cell == nil) {
            cell = [[AboutLogoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
        }
        cell.headerLabel.text = [appDelegate.bundles.vendor.mobile_title kv_stripHTMLCharacterEntities];
        cell.subHeaderLabel.text = [appDelegate.bundles.vendor.mobile_subject kv_stripHTMLCharacterEntities];
        [cell.logoImage setImageWithURL:[NSURL URLWithString:appDelegate.bundles.vendor.mobile_logo_url] placeholderImage:[UIImage imageNamed:@""]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1 || indexPath.row == 2) {
        AboutPhoneCell *cell = (AboutPhoneCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[AboutPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        if (indexPath.row == 1) {
            cell.phoneLabel.text = appDelegate.bundles.vendor.phone;
            [cell.onPhoneButton setTitle:@"позвонить" forState:UIControlStateNormal];
            [cell.onPhoneButton addTarget:self action:@selector(onCall:) forControlEvents:UIControlEventTouchUpInside];
        }
        else  if (indexPath.row == 2) {
            cell.phoneLabel.text = @"Крылова, 7";
            [cell.onPhoneButton setTitle:@"на карте" forState:UIControlStateNormal];
            [cell.onPhoneButton addTarget:self action:@selector(onMap:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    /*
    else if(indexPath.row == 3) {
        AboutDeliveryCell *cell = (AboutDeliveryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[AboutDeliveryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
        }
        [cell.onDeliveryButton setTitle:@"Доставка и оплата" forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
     */
    else if(indexPath.row == 3) {
        AboutTextCell *cell = (AboutTextCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil) {
            cell = [[AboutTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4];
        }
        
        [cell.webView loadHTMLString:appDelegate.bundles.vendor.mobile_description baseURL:nil];
        cell.webView.delegate = self;
        [cell.contentView setFrame:CGRectMake(10, 0, 300, 670)];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.row == 4) {
        AboutOtherCell *cell = (AboutOtherCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
        if (cell == nil) {
            cell = [[AboutOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier5];
        }
        cell.cityLabel.text = appDelegate.bundles.vendor.city;
        
        NSString* date = [appDelegate.convertTime iso8601_to_ddMMYYYY:appDelegate.bundles.vendor.updated_at];
        cell.lastUpdateLabel.text = [NSString stringWithFormat:@"Последнее обновление от %@", date];
        
        [cell.onUpdateButton setTitle:@"Обновить" forState:UIControlStateNormal];
        [cell.onUpdateButton addTarget:self action:@selector(onUpdate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
        
        cell.versionLabel.text = [NSString stringWithFormat:@"Версия приложения: %@ (%@)",majorVersion, minorVersion];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            [self onCall:nil];
            break;
        case 2:
            [self onMap:nil];
            break;
        default:
            break;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //heightWebView = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] integerValue] + 65;
    //[self.tableView reloadData];
}

- (IBAction)onCall:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",appDelegate.bundles.vendor.phone]]];
    } else {
        UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:nil message:@"Устройство не поддерживает эту функцию." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notPermitted show];
    }
}

- (IBAction)onMap:(id)sender {
    [self performSegueWithIdentifier:@"segMap" sender:self];
}

- (IBAction)onUpdate:(id)sender {
    [self networkActivity:YES];
    [appDelegate.managers getBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        
        [self.tableView reloadData];
        [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];
        
        appDelegate.cart.vendor = bundles.vendor;
        [self networkActivity:NO];
    } failBlock:^(NSException * exception) {
        [self showAlertException:exception];
    }];
}

@end
