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
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *profileId;

@end

@implementation HomeViewController

@synthesize soberLabel, goalsTextView, goalsTitleLabel, currentUser, goals, username, profileId;

UIBackgroundTaskIdentifier counterTask;
static NSString* dateString;
static UITextView *dateTextView;
static NSString *timeString;

int days = 0;
NSTimer *timer;

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
    
    currentUser = [PFUser currentUser];
    
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
    
    if (currentUser){
        UIBarButtonItem *startButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(startTimer)];
        [startButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
        self.navigationItem.rightBarButtonItem = startButtonItem;
    }
    
    //Getting User Data From Parse
    username = [currentUser username];
    goals = currentUser[@"userGoals"];
    
    if (currentUser){
        PFQuery *query = [PFQuery queryWithClassName:@"profilesList"];
        [query whereKey:@"profileUserName" equalTo:username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                NSLog(@"Successfully retrieved %d profile.", objects.count);
                for (PFObject *object in objects) {
                    profileId = object.objectId;
                    dateString = object[@"startSobrietyDate"];
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

    }
    
    UIView * soberLabelView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, 320.0f, 50.0f)];
    [soberLabelView setBackgroundColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:0.7f]];
    [self.view addSubview:soberLabelView];
    
    soberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    [soberLabel setText:@"MY NUMBER OF DAYS SOBER"];
    [soberLabel setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [soberLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [soberLabel setBackgroundColor:[UIColor clearColor]];
    [soberLabel setTextAlignment:NSTextAlignmentCenter];
    [soberLabelView addSubview:soberLabel];
    
    if (!currentUser){
        dateTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 114.0f, 320.0f, 160.0f)];
        [dateTextView setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
        [dateTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:26]];
        [dateTextView setBackgroundColor:[UIColor clearColor]];
        [dateTextView setTextAlignment:NSTextAlignmentCenter];
        [dateTextView setText:@"Please Log In To Set Your Sobriety Clock"];
        [dateTextView setEditable:NO];
        [self.view addSubview:dateTextView];
    } else {
        dateTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 114.0f, 320.0f, 160.0f)];
        [dateTextView setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
        [dateTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:48]];
        [dateTextView setBackgroundColor:[UIColor clearColor]];
        [dateTextView setTextAlignment:NSTextAlignmentCenter];
        [dateTextView setEditable:NO];
        [self.view addSubview:dateTextView];
    }
    
    UIView * goalsLabelView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 274.0f, 320.0f, 50.0f)];
    [goalsLabelView setBackgroundColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:0.7f]];
    [self.view addSubview:goalsLabelView];
    
    goalsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    [goalsTitleLabel setText:@"MY GOALS ARE TO"];
    [goalsTitleLabel setTextColor:[UIColor colorWithRed:225.0f/255.0f green:219.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [goalsTitleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [goalsTitleLabel setBackgroundColor:[UIColor clearColor]];
    [goalsTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [goalsLabelView addSubview:goalsTitleLabel];
    
    goalsTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 324.0f, 320.0f, 240.0f)];
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

- (void)startTimer
{
    if (days == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Start Sobriety Watch"
                                                        message:@"Congrats! Today's Your First Day!"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Go", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sobriety Watch"
                                                        message:@"Reset or Stop Sobriety Watch?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Reset", @"Stop", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM dd yyyy"];
        dateString = [dateFormat stringFromDate:today];
        
        PFQuery *query = [PFQuery queryWithClassName:@"profilesList"];
        [query getObjectInBackgroundWithId:profileId block:^(PFObject *userProfileSave, NSError *error) {
            userProfileSave[@"startSobrietyDate"] = dateString;
            [userProfileSave saveEventually];
        }];
        [[UIApplication sharedApplication] endBackgroundTask:counterTask];
        
        [self resetTimer];
    } else if (buttonIndex == 2){
        NSLog(@"Time ended.");
        [[UIApplication sharedApplication] endBackgroundTask:counterTask];
        [timer invalidate];
        dateTextView.text = @"";
        days = 0;
    }
}

- (void)resetTimer
{
    [self startCounter];
}

- (void)startCounter {
    [timer invalidate];
    
    counterTask = [[UIApplication sharedApplication]
                   beginBackgroundTaskWithExpirationHandler:^{
                       
                   }];
    
    days = 0;
    
    if (days == 0){
        timeString = [[NSString alloc] initWithFormat:@"0 Days as of %@", dateString];
    }
    
    dateTextView.text = timeString;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:86400 target:self selector:@selector(dayCounter) userInfo:nil repeats:YES];
}

- (void)dayCounter
{
    NSLog(@"Day Counter Active");
    
    days++;
    
    if (days == 0){
        timeString = [[NSString alloc] initWithFormat:@"0 Days as of %@", dateString];
    } else if (days == 1) {
        timeString = [[NSString alloc] initWithFormat:@"%d Day as of %@", days, dateString];
    } else if (days > 1) {
        timeString = [[NSString alloc] initWithFormat:@"%d Days as of %@", days, dateString];
    }
    
    dateTextView.text = timeString;
}

@end
