//
//  HomeTableViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "MeetingsTableViewController.h"
#import "SWRevealViewController.h"
#import "NSDictionary+Data.h"
#import "MBProgressHUD.h"

@interface MeetingsTableViewController ()

@property (nonatomic, strong) NSArray * locationList;
@property (nonatomic, strong) NSDictionary * locationDict;

@end

@implementation MeetingsTableViewController

@synthesize backgroundImageView, sections, locationDict, locationList;

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
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"json"];
    
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    locationList = [jsonObject locationsArray];
    
    sections = [[NSMutableDictionary alloc] init];
    BOOL found;
    for (NSDictionary *temp in locationList){
        NSString *c = [temp objectForKey:@"Day"];
        found = NO;
        for (NSString *str in [sections allKeys]) {
            if ([str isEqualToString:c]) {
                found = YES;
            }
        }
        if (!found) {
            [sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
    for (NSDictionary *temp in locationList){
        [[sections objectForKey:[temp objectForKey:@"Day"]] addObject:temp];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[sections allKeys] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections valueForKey:[[sections allKeys] objectAtIndex:section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    locationDict = [[self.sections valueForKey:[[self.sections allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
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
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ at %@",[locationDict groupNameString], [locationDict timeString]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@",[locationDict addressString],[locationDict cityString]]];
    
    return cell;
}

@end
