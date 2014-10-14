//
//  LeftMenu.m
//  Kormilica
//
//  Created by bespalown on 13/10/14.
//  Copyright (c) 2014 Brandymint. All rights reserved.
//

#import "LeftMenu.h"
#import "RESideMenu.h"

@interface LeftMenu ()
@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation LeftMenu
{
    NSArray *titles;
    NSArray *images;
    CGFloat spacing;
    
    NSMutableArray *sectionsDataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[VBStyle sharedInstance] menuBackground];
    
    spacing = 100;
    
    [appDelegate.managers getLocalBundles:^(Bundles* bundles) {
        appDelegate.bundles = bundles;
        appDelegate.cart.vendor = bundles.vendor;
    }];

    sectionsDataArray = [NSMutableArray new];
    for (int i = 0; i < appDelegate.bundles.categories.count; i++) {
        [sectionsDataArray addObject:[[appDelegate.bundles.categories objectAtIndex:i] name]];
    }
    
    [self loadInterface];
    //[self performSelectorInBackground:@selector(loadInterface) withObject:nil];
}

-(void)loadInterface
{
    titles = @[
               NSLocalizedString(@"Каталог", nil),
               NSLocalizedString(@"Корзина", nil),
               NSLocalizedString(@"Поиск", nil),
               NSLocalizedString(@"Отзыв", nil),
               NSLocalizedString(@"Контакты", nil)
               ];
    images = @[
               @"catalog",
               @"cart",
               @"search",
               @"chat",
               @"circled-info"
               ];
    //.
        self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:
                                  CGRectMake(0,
                                             30,
                                             self.view.frame.size.width,
                                             spacing * titles.count)
                                                              style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

-(void)tableViewCellContentColor:(UIColor *)theContentColor atIndexPath:(NSIndexPath *)theIndexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:theIndexPath];
    cell.textLabel.textColor = theContentColor;
    //cell.imageView.image = [cell.imageView.image imageWithColor:theContentColor];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            //
            break;
        case 2:
            //
            break;
        case 3:
            //
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return sectionsDataArray.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [[VBStyle sharedInstance] menuFont];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text = titles[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.section]];
    
    if (indexPath.section == 0 && indexPath.row > 0) {
        cell.textLabel.text = sectionsDataArray[indexPath.row - 1];
        cell.imageView.image = [UIImage imageNamed:@"point"];
    }
    
    return cell;
}

@end
