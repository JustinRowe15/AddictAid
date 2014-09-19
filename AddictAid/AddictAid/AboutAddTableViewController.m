//
//  AboutAddTableViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "AboutAddTableViewController.h"
#import "SWRevealViewController.h"
#import "NSDictionary+Data.h"
#import "MBProgressHUD.h"
#import "DefinitionDetailViewController.h"

@interface AboutAddTableViewController ()

@property (nonatomic, strong) NSArray * glossaryList;
@property (nonatomic, strong) NSDictionary * glossaryDict;
@property (nonatomic, strong) NSDictionary * jsonObject;

@end

@implementation AboutAddTableViewController

@synthesize backgroundImageView ,sections, glossaryList, glossaryDict, jsonObject;

int definitions = 0;

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
    
    self.tableView.delegate = self;
    
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
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 52.0f, 50.0f)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor clearColor];
    button.frame = buttonView.frame;
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:15];
    [button setTitle:@"Define" forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1]];
    button.autoresizesSubviews = YES;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button];
    
    UIBarButtonItem *actionBarButton = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    self.navigationItem.rightBarButtonItem = actionBarButton;
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    
    [self getDefinitions];
}

- (void)getDefinitions
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"glossary" ofType:@"json"];
    
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:filePath];
    jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    if (definitions == 0){
         glossaryList = [jsonObject glossaryArray];
    } else if (definitions == 1) {
        glossaryList = [jsonObject alcoholArray];
    } else if (definitions == 2) {
        glossaryList = [jsonObject drugsArray];
    }
    
    [self sortLetters];
}

- (void)sortLetters {
    sections = [[NSMutableDictionary alloc] init];
    BOOL found;
    for (NSDictionary *temp in glossaryList){
        NSString *c = [[temp objectForKey:@"Term"] substringToIndex:1];
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
    for (NSDictionary *temp in glossaryList){
        [[sections objectForKey:[[temp objectForKey:@"Term"] substringToIndex:1]] addObject:temp];
    }
    for (NSString *key in [sections allKeys])
    {
        [[sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"Term" ascending:YES]]];
    }
    
    [self.tableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Alcohol"]) {
        definitions = 1;
        [self getDefinitions];
    }
    if ([buttonTitle isEqualToString:@"Drugs"]) {
        definitions = 2;
        [self getDefinitions];
    }
    if ([buttonTitle isEqualToString:@"Both"]) {
        definitions = 0;
        [self getDefinitions];
    }
    if ([buttonTitle isEqualToString:@"Cancel Button"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
    
}

- (void)showActionSheet:(id)sender
{
    NSString * actionSheetTitle = @"Display Definitions";
    NSString * button1 = @"Alcohol";
    NSString * button2 = @"Drugs";
    NSString * button3 = @"Both";
    NSString * cancelTitle = @"Cancel";
    UIActionSheet * actionSheet = [[UIActionSheet alloc]
                                   initWithTitle:actionSheetTitle
                                   delegate:self
                                   cancelButtonTitle:cancelTitle
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:button1, button2, button3, nil];
    [actionSheet showInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *indexArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    return indexArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    glossaryDict = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
	
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
        cell.textLabel.textColor = [UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor clearColor];
	}
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[glossaryDict termsString]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefinitionDetailViewController *definitionDetailViewController = [[DefinitionDetailViewController alloc]init];
    definitionDetailViewController.detailDefinition = [[[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] definitionsString];
    definitionDetailViewController.title = [[[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] termsString];
    [self.navigationController pushViewController:definitionDetailViewController animated:YES];
}

@end
