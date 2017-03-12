//
//  QuotesTableViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "QuotesTableViewController.h"
#import "QuoteDetailViewController.h"
#import "SWRevealViewController.h"
#import "NSDictionary+Data.h"
#import "MBProgressHUD.h"

@interface QuotesTableViewController ()

@property (nonatomic, strong) NSArray * quotesList;
@property (nonatomic, strong) NSDictionary * quotesDict;
@property (nonatomic, strong) NSDictionary *jsonObject;

@end

@implementation QuotesTableViewController

@synthesize backgroundImageView, quotesList, quotesDict, jsonObject;

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
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"json"];
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:filePath];
    jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    quotesList = [jsonObject quotesArray];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)quotesList.count);
    return quotesList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *quote = [[quotesList objectAtIndex:indexPath.row] quoteString];
    NSString *author = [[quotesList objectAtIndex:indexPath.row] authorString];
    
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
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",quote]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",author]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuoteDetailViewController *quoteDetailViewController = [[QuoteDetailViewController alloc]init];
    quoteDetailViewController.detailQuote = [[quotesList objectAtIndex:indexPath.row] quoteString];
    quoteDetailViewController.title = [[quotesList objectAtIndex:indexPath.row] authorString];
    [self.navigationController pushViewController:quoteDetailViewController animated:YES];
}

@end
