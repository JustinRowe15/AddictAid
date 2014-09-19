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

@property (nonatomic, strong) NSArray * locationList;
@property (nonatomic, strong) NSDictionary * locationDict;

@end

@implementation MeetingsTableViewController

@synthesize backgroundImageView, sections, locationDict, locationList, daySelected;

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
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return daySelected;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 320, 20);
    label.backgroundColor = [UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:0.7f];
    label.textColor = [UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
    label.font = [UIFont fontWithName:@"Avenir-Light" size:15];
    label.text = [NSString stringWithFormat:@"    %@", sectionTitle]; 
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return locationList.count;
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
