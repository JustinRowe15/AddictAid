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
#import "ContactUsViewController.h"
#import "MyProfileViewController.h"
#import "UsersListViewController.h"
#import "MyMessagesViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController

@synthesize currentUser, userNameString;

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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    currentUser = [PFUser currentUser];
    if (!currentUser){
        userNameString = [NSString stringWithFormat:@"AddictAid Menu"];
    } else {
        userNameString = [NSString stringWithFormat:@"Welcome %@", [currentUser username]];
    }
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [userNameLabel setText:userNameString];
    [userNameLabel setTextColor:[UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f]];
    [userNameLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:20]];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc] initWithCustomView:userNameLabel];
    
    NSArray *actionButtonItems = @[labelItem];
    self.navigationItem.leftBarButtonItems = actionButtonItems;
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
    if (currentUser){
        return 9;
    } else {
        return 6;
    }
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
    
    if (currentUser) {
        if (row == 0)
        {
            cell.textLabel.text = @"YOUR GOALS";
        }
        else if (row == 1)
        {
            cell.textLabel.text = @"MEETING INFO";
        }
        else if (row == 2)
        {
            cell.textLabel.text = @"ABOUT ADDICTIONS";
        }
        else if (row == 3)
        {
            cell.textLabel.text = @"QUOTES";
        }
        else if (row == 4)
        {
            cell.textLabel.text = @"SEARCH USERS";
        }
        else if (row == 5)
        {
            cell.textLabel.text = @"CONTACT US";
        }
        else if (row == 6)
        {
            cell.textLabel.text = @"MY PROFILE";
        }
        else if (row == 7)
        {
            cell.textLabel.text = @"MY MESSAGES";
        }
        else if (row == 8)
        {
            cell.textLabel.text = @"LOG OUT";
        }
    } else {
        if (row == 0)
        {
            cell.textLabel.text = @"YOUR GOALS";
        }
        else if (row == 1)
        {
            cell.textLabel.text = @"MEETING INFO";
        }
        else if (row == 2)
        {
            cell.textLabel.text = @"ABOUT ADDICTIONS";
        }
        else if (row == 3)
        {
            cell.textLabel.text = @"QUOTES";
        }
        else if (row == 4)
        {
            cell.textLabel.text = @"CONTACT US";
        }
        else if (row == 5)
        {
            cell.textLabel.text = @"LOG IN";
        }
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
        } else {
			[revealController revealToggle:self];
		}
	}
	else if (row == 1)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[MeetingsTableViewController class]] )
        {
			MeetingsTableViewController *meetingsTableViewController = [[MeetingsTableViewController alloc] init];
            meetingsTableViewController.title = @"Meetings";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:meetingsTableViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        } else {
			[revealController revealToggle:self];
		}
	}
	else if (row == 2)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[AboutAddTableViewController class]] )
        {
			AboutAddTableViewController *aboutAddViewController = [[AboutAddTableViewController alloc] init];
            aboutAddViewController.title = @"About Addictions";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:aboutAddViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        } else {
			[revealController revealToggle:self];
		}
	}
    else if (row == 3)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[QuotesTableViewController class]] )
        {
			QuotesTableViewController *quotesTableViewController = [[QuotesTableViewController alloc] init];
            quotesTableViewController.title = @"Quotes";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:quotesTableViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        } else {
			[revealController revealToggle:self];
		}
	}
    else if (row == 4)
	{
        if (currentUser){
            if ( ![frontNavigationController.topViewController isKindOfClass:[UsersListViewController class]] )
            {
                UsersListViewController *usersListViewController = [[UsersListViewController alloc] init];
                usersListViewController.title = @"Search Users";
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:usersListViewController];
                [revealController setFrontViewController:navigationController animated:YES];
            } else {
                [revealController revealToggle:self];
            }
        } else {
            if ( ![frontNavigationController.topViewController isKindOfClass:[ContactUsViewController class]] )
            {
                ContactUsViewController *contactUsViewController = [[ContactUsViewController alloc] init];
                contactUsViewController.title = @"Contact Us";
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:contactUsViewController];
                [revealController setFrontViewController:navigationController animated:YES];
            } else {
                [revealController revealToggle:self];
            }
        }
	}
    else if (row == 5)
	{
        if (currentUser) {
            if ( ![frontNavigationController.topViewController isKindOfClass:[ContactUsViewController class]] )
            {
                ContactUsViewController *contactUsViewController = [[ContactUsViewController alloc] init];
                contactUsViewController.title = @"Contact Us";
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:contactUsViewController];
                [revealController setFrontViewController:navigationController animated:YES];
            } else {
                [revealController revealToggle:self];
            }
        } else {
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewController];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
	}
    else if (row == 6)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[MyProfileViewController class]] )
        {
            MyProfileViewController *myProfileViewController = [[MyProfileViewController alloc] init];
            myProfileViewController.title = @"My Profile";
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:myProfileViewController];
            [revealController setFrontViewController:navigationController animated:YES];
        } else {
            [revealController revealToggle:self];
        }
	}
    else if (row == 7)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[MyMessagesViewController class]] )
        {
			MyMessagesViewController *myMessagesViewController = [[MyMessagesViewController alloc] init];
            myMessagesViewController.title = @"My Messages";
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:myMessagesViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        } else {
			[revealController revealToggle:self];
		}
	}
    else if (row == 8)
	{
        [PFUser logOut];
        PFUser *currentUser = [PFUser currentUser];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewController];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}
}

@end
