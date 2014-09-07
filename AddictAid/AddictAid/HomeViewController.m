//
//  HomeViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface HomeViewController ()

@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSString *goals;

@end

@implementation HomeViewController

@synthesize soberLabel, dateTextView, goalsTextView, goalsTitleLabel, currentUser, goals;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    } else {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"background4.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem *timerButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(resetTimer:)];
    [timerButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.rightBarButtonItem = timerButtonItem;
    
    //Getting User Data From Parse
    PFQuery * userQuery = [PFUser query];
    currentUser = [PFUser currentUser];
    NSArray *userArray = [userQuery findObjects];
    for (PFObject *object in userArray) {
        goals = [NSString stringWithFormat:@"%@", [object objectForKey:@"userGoals"]];
    }

    
    UIView * soberLabelView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, 320.0f, 50.0f)];
    [soberLabelView setBackgroundColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:0.7f]];
    [self.view addSubview:soberLabelView];
    
    soberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    [soberLabel setText:@"I HAVE BEEN SOBER FOR"];
    [soberLabel setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [soberLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [soberLabel setBackgroundColor:[UIColor clearColor]];
    [soberLabel setTextAlignment:NSTextAlignmentCenter];
    [soberLabelView addSubview:soberLabel];
    
    dateTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 114.0f, 320.0f, 200.0f)];
    [dateTextView setText:@"34 DAYS AS OF MARCH 24, 2014"];
    [dateTextView setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [dateTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:42]];
    [dateTextView setBackgroundColor:[UIColor clearColor]];
    [dateTextView setTextAlignment:NSTextAlignmentCenter];
    [dateTextView setEditable:NO];
    [self.view addSubview:dateTextView];
    
    UIView * goalsLabelView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 314.0f, 320.0f, 50.0f)];
    [goalsLabelView setBackgroundColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:0.7f]];
    [self.view addSubview:goalsLabelView];
    
    goalsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    [goalsTitleLabel setText:@"MY GOALS ARE TO"];
    [goalsTitleLabel setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [goalsTitleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [goalsTitleLabel setBackgroundColor:[UIColor clearColor]];
    [goalsTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [goalsLabelView addSubview:goalsTitleLabel];
    
    goalsTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 364.0f, 320.0f, 200.0f)];
    [goalsTextView setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [goalsTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:26]];
    [goalsTextView setBackgroundColor:[UIColor clearColor]];
    [goalsTextView setTextAlignment:NSTextAlignmentCenter];
    [goalsTextView setEditable:NO];
    [self.view addSubview:goalsTextView];
    
    if (currentUser){
        [goalsTextView setText:goals];
    } else {
        [goalsTextView setText:@"Please Log In To Set Your Goals!"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetTimer:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Good Luck!"
                                                    message:@"Today's Your First Day!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
