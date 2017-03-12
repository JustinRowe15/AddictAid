//
//  UsersListViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "UsersListViewController.h"
#import "SWRevealViewController.h"
#import "UserDetailViewController.h"

@interface UsersListViewController ()

@end

@implementation UsersListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.parseClassName = @"profilesList";
        self.textKey = @"profileUserName";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 15;
        
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.opaque = NO;
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
    
    //Setting Left Bar Button Label
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query whereKey:@"profilePublic" equalTo:@"YES"];
    
    return query;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
        cell.textLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"profileUserName"];
    cell.detailTextLabel.text = [object objectForKey:@"profileCurrentLocation"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    PFObject * selectedCell = [self.objects objectAtIndex:indexPath.row];
    UserDetailViewController * userDetailViewController = [[UserDetailViewController alloc] init];
    [userDetailViewController setRecievedUser:selectedCell];
    userDetailViewController.title = [[self.objects objectAtIndex:indexPath.row] objectForKey:@"profileUserName"];
    [self.navigationController pushViewController:userDetailViewController animated:YES];
}

@end
