//
//  UserDetailViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

@synthesize profileInterestsLabel, profileLocationLabel, profileUsernameLabel, usernameTextField, interestsTextView, locationTextField, profileGoalsLabel, goalsTextView;

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
    
    //Setting Background Image
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
    
    [self setUserView];
}

- (void)setUserView
{
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 110.0f, 14.0f)];
    [usernameLabel setText:@"Username:"];
    [usernameLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [usernameLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    [usernameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:usernameLabel];
    
    UIView * profileUsernameTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 96.0f, 280.0f, 38.0f)];
    [profileUsernameTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileUsernameTextFieldView];
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [usernameTextField setBorderStyle:UITextBorderStyleNone];
    [usernameTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [usernameTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [usernameTextField setBackgroundColor:[UIColor clearColor]];
    [profileUsernameTextFieldView addSubview:usernameTextField];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 136.0f, 110.0f, 14.0f)];
    [locationLabel setText:@"Location:"];
    [locationLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [locationLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [locationLabel setTextAlignment:NSTextAlignmentLeft];
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:locationLabel];
    
    UIView * profileLocationTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 152.0f, 280.0f, 38.0f)];
    [profileLocationTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileLocationTextFieldView];
    
    locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [locationTextField setBorderStyle:UITextBorderStyleNone];
    [locationTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [locationTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [locationTextField setBackgroundColor:[UIColor clearColor]];
    [profileLocationTextFieldView addSubview:locationTextField];
    
    UILabel *interestLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 192.0f, 110.0f, 14.0f)];
    [interestLabel setText:@"Interests:"];
    [interestLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [interestLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [interestLabel setTextAlignment:NSTextAlignmentLeft];
    [interestLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:interestLabel];
    
    UIView * profileInterestsLabelView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 208.0f, 280.0f, 126.0f)];
    [profileInterestsLabelView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileInterestsLabelView];
    
    interestsTextView = [[UITextView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 126.0f)];
    [interestsTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [interestsTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [interestsTextView setBackgroundColor:[UIColor clearColor]];
    [profileInterestsLabelView addSubview:interestsTextView];
    
    UILabel *goalsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 336.0f, 110.0f, 14.0f)];
    [goalsLabel setText:@"Goals:"];
    [goalsLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [goalsLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [goalsLabel setTextAlignment:NSTextAlignmentLeft];
    [goalsLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:goalsLabel];
    
    UIView * profileGoalsLabelView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 352.0f, 280.0f, 186.0f)];
    [profileGoalsLabelView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileGoalsLabelView];
    
    goalsTextView = [[UITextView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 186.0f)];
    [goalsTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [goalsTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [goalsTextView setBackgroundColor:[UIColor clearColor]];
    [profileGoalsLabelView addSubview:goalsTextView];
    
    if(self.recievedUser)
    {
        NSString * objectUserName = [self.recievedUser objectForKey:@"profileUserName"];
        [usernameTextField setText:objectUserName];
        [usernameTextField setEnabled:NO];
        
        NSString * objectUserLocation = [self.recievedUser objectForKey:@"profileCurrentLocation"];
        [locationTextField setText:objectUserLocation];
        [locationTextField setEnabled:NO];
        
        NSString * objectUserInterests = [self.recievedUser objectForKey:@"profileInterests"];
        [interestsTextView setText:objectUserInterests];
        [interestsTextView setEditable:NO];
        
        NSString * objectUserGoals = [self.recievedUser objectForKey:@"profileGoals"];
        [goalsTextView setText:objectUserGoals];
        [goalsTextView setEditable:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
