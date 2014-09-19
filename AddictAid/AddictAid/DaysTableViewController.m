//
//  DaysTableViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/18/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "DaysTableViewController.h"
#import "MeetingsTableViewController.h"
#import "SWRevealViewController.h"

@interface DaysTableViewController ()

@end

@implementation DaysTableViewController

@synthesize backgroundImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background5.png"]];
    [self.tableView setBackgroundView:backgroundImageView];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (row == 0)
    {
        cell.textLabel.text = @"SUNDAY";
    }
    else if (row == 1)
    {
        cell.textLabel.text = @"MONDAY";
    }
    else if (row == 2)
    {
        cell.textLabel.text = @"TUESDAY";
    }
    else if (row == 3)
    {
        cell.textLabel.text = @"WEDNESDAY";
    }
    else if (row == 4)
    {
        cell.textLabel.text = @"THURSDAY";
    }
    else if (row == 5)
    {
        cell.textLabel.text = @"FRIDAY";
    }
    else if (row == 6)
    {
        cell.textLabel.text = @"SATURDAY";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 0){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Sunday";
        meetingsTableViewController.title = @"Sunday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    } else if (row == 1){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Monday";
        meetingsTableViewController.title = @"Monday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    } else if (row == 2){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Tuesday";
        meetingsTableViewController.title = @"Tuesday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    } else if (row == 3){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Wednesday";
        meetingsTableViewController.title = @"Wednesday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    } else if (row == 4){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Thursday";
        meetingsTableViewController.title = @"Thursday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    } else if (row == 5){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Friday";
        meetingsTableViewController.title = @"Friday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    } else if (row == 6){
        MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc]init];
        meetingsTableViewController.daySelected = @"Saturday";
        meetingsTableViewController.title = @"Saturday";
        [self.navigationController pushViewController:meetingsTableViewController animated:YES];
    }
}


@end
