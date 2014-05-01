//
//  TableViewController.h
//  ScrollingNavbarDemo
//
//  Created by Hao Zheng on 4/20/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.

#import "TableViewController.h"
#import "UIViewController+ScrollingNavbar.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* data;

@end

@implementation TableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    
	
	self.data = @[@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake",@"Pea", @"Corn", @"NYSteak", @"Shake"];
	
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
	self.edgesForExtendedLayout = UIRectEdgeNone;
    
	// Just call this line to enable the scrolling navbar
	//[self followScrollView:self.tableView];
}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	// Call this after a small delay, or it won't work
	[self performSelector:@selector(showNavbar) withObject:nil afterDelay:0.2];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	// This enables the user to scroll down the navbar by tapping the status bar.
	[self showNavbar];
	
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
	}
	
	cell.textLabel.text = self.data[indexPath.row];
	
	return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.title = @"Table";
    
    UIBarButtonItem *barAddButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Friends" style:UIBarButtonItemStylePlain target:self action:@selector(addFriends)];
    self.tabBarController.navigationItem.rightBarButtonItem = barAddButton;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	//[self showNavBarAnimated:NO];
    
    //
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

-(void)addFriends{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FindContacts"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
