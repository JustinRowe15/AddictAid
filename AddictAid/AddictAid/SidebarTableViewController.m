//
//  SidebarTableViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "MeetingsTableViewController.h"
#import "AboutAddTableViewController.h"
#import "QuotesTableViewController.h"
#import "YourGoalsTableViewController.h"
#import "ContactUsViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController

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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"background5.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView * imageView = [[UIImageView alloc] initWithImage:newImage];
        [self.tableView setBackgroundView:imageView];
    } else {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"background4.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView * imageView = [[UIImageView alloc] initWithImage:newImage];
        [self.tableView setBackgroundView:imageView];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
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
        cell.textLabel.textColor = [UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor clearColor];
	}
	
	if (row == 0)
	{
		cell.textLabel.text = @"HOME";
	}
	else if (row == 1)
	{
		cell.textLabel.text = @"YOUR GOALS";
	}
	else if (row == 2)
	{
		cell.textLabel.text = @"MEETING INFO";
	}
	else if (row == 3)
	{
		cell.textLabel.text = @"ABOUT ADDICTIONS";
	}
    else if (row == 4)
	{
		cell.textLabel.text = @"QUOTES";
	}
    else if (row == 5)
	{
		cell.textLabel.text = @"CONTACT US";
	}
    else if (row == 6)
	{
		cell.textLabel.text = @"LOG OUT";
	}
	
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SWRevealViewController *revealController = self.revealViewController;
    UINavigationController *frontNavigationController = (id)revealController.frontViewController;
    NSInteger row = indexPath.row;

	if (row == 0)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[HomeViewController class]] )
        {
			HomeViewController * homeViewController = [[HomeViewController alloc] init];
            homeViewController.title = @"Welcome to AddictAid";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		else
		{
			[revealController revealToggle:self];
		}
	}
	else if (row == 1)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[YourGoalsTableViewController class]] )
        {
			YourGoalsTableViewController *yourGoalsViewController = [[YourGoalsTableViewController alloc] init];
            yourGoalsViewController.title = @"Your Goals";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:yourGoalsViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
		else
		{
			[revealController revealToggle:self];
		}
	}
	else if (row == 2)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[MeetingsTableViewController class]] )
        {
			MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc] init];
            meetingsTableViewController.title = @"Meetings";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:meetingsTableViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (row == 3)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[AboutAddTableViewController class]] )
        {
			AboutAddTableViewController *aboutAddViewController = [[AboutAddTableViewController alloc] init];
            aboutAddViewController.title = @"About Addictions";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:aboutAddViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (row == 4)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[QuotesTableViewController class]] )
        {
			QuotesTableViewController *quotesTableViewController = [[QuotesTableViewController alloc] init];
            quotesTableViewController.title = @"Meetings";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:quotesTableViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (row == 5)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[ContactUsViewController class]] )
        {
			ContactUsViewController *contactUsViewController = [[ContactUsViewController alloc] init];
            contactUsViewController.title = @"Meetings";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:contactUsViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (row == 6)
	{
        [PFUser logOut];
        PFUser *currentUser = [PFUser currentUser];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewController];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}
}

@end
