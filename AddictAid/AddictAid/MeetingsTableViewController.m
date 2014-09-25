//
//  HomeTableViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "MeetingsTableViewController.h"
#import "NSDictionary+Data.h"
#import "MBProgressHUD.h"

@interface MeetingsTableViewController ()

@property (nonatomic, strong) NSArray *locationList;
@property (nonatomic, strong) NSArray *searchData;
@property (nonatomic, strong) NSMutableDictionary *locationDict;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;

@end

@implementation MeetingsTableViewController

@synthesize backgroundImageView, sections, locationDict, locationList, daySelected, groupName, time, address, city, searchBar, searchDisplayController, searchData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background5.png"]];
    [self.tableView setBackgroundView:backgroundImageView];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.delegate = self;
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = searchBar;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"json"];
    
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    locationList = [jsonObject objectForKey:[NSString stringWithFormat:@"%@", daySelected]];
    [self.tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"City contains[c] %@", searchText];
    searchData = [locationList filteredArrayUsingPredicate:resultPredicate];
    NSLog(@"Search data: %@", searchData);
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchData count];
        
    } else {
        return [locationList count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSMutableDictionary *dict;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        dict = [searchData objectAtIndex:indexPath.row];
    } else {
        dict = [locationList objectAtIndex:indexPath.row];
    }
    
    groupName = [dict groupNameString];
    time = [dict timeString];
    address = [dict addressString];
    city = [dict cityString];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
	
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
        cell.textLabel.textColor = [UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor clearColor];
	}
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ at %@", groupName, time]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@", address, city]];
    
    return cell;
}

@end
