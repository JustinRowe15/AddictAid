//
//  MyProfileViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "MyProfileViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface MyProfileViewController ()

@property (nonatomic, strong) UIBarButtonItem *saveButtonItem;
@property (nonatomic, strong) UIBarButtonItem *editButtonItem;
@property (nonatomic, strong) NSString *userPhoto;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *interests;
@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation MyProfileViewController

@synthesize profileEmailAddressLabel, profileImageView, profileInterestsLabel, profileLocationLabel, profileUsernameLabel, usernameTextField, interestsTextView, locationTextField, emailAddressTextField, username, userPhoto, emailAddress, location, interests, currentUser, saveButtonItem, editButtonItem;

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
    
    //Setting Left Bar Button Label
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    //Setting Right Bar Button Label
    editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editProfile)];
    [editButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:16.0f]} forState:UIControlStateNormal];
    [editButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.rightBarButtonItem = editButtonItem;
    
    saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveProfile)];
    [saveButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:16.0f]} forState:UIControlStateNormal];
    [saveButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    
    //Getting User Data From Parse
    PFQuery * userQuery = [PFUser query];
    currentUser = [PFUser currentUser];
    NSArray *userArray = [userQuery findObjects];
    for (PFObject *object in userArray) {
        username = [NSString stringWithFormat:@"%@", [currentUser username]];
        emailAddress = [NSString stringWithFormat:@"%@", [object objectForKey:@"userEmailAddress"]];
        location = [NSString stringWithFormat:@"%@", [object objectForKey:@"userCurrentLocation"]];
        userPhoto = [NSString stringWithFormat:@"%@", [object objectForKey:@"userImage"]];
        interests = [NSString stringWithFormat:@"%@", [object objectForKey:@"userInterests"]];
    }
    
    [self setProfileView];
}

- (void)setProfileView
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userPhoto]]];
    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    [profileImageView setImage:image];
    
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 80.0f, 80.0f)];
    newView.clipsToBounds = YES;
    newView.layer.cornerRadius = 40.0f;
    [newView addSubview:profileImageView];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 80.0f, 110.0f, 14.0f)];
    [usernameLabel setText:@"Username:"];
    [usernameLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [usernameLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    [usernameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:usernameLabel];
    
    UIView * profileUsernameTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(120.0f, 96.0f, 180.0f, 38.0f)];
    [profileUsernameTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileUsernameTextFieldView];
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 172.0f, 38.0f)];
    [usernameTextField setBorderStyle:UITextBorderStyleNone];
    [usernameTextField setEnabled:NO];
    [usernameTextField setText:[NSString stringWithFormat:@"%@", username]];
    [usernameTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [usernameTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [usernameTextField setBackgroundColor:[UIColor clearColor]];
    [profileUsernameTextFieldView addSubview:usernameTextField];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 136.0f, 110.0f, 14.0f)];
    [locationLabel setText:@"Location:"];
    [locationLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [locationLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [locationLabel setTextAlignment:NSTextAlignmentLeft];
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:locationLabel];
    
    UIView * profileLocationTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(120.0f, 152.0f, 180.0f, 38.0f)];
    [profileLocationTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileLocationTextFieldView];
    
    locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 172.0f, 38.0f)];
    [locationTextField setBorderStyle:UITextBorderStyleNone];
    [locationTextField setEnabled:NO];
    [locationTextField setText:[NSString stringWithFormat:@"%@", location]];
    [locationTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [locationTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [locationTextField setBackgroundColor:[UIColor clearColor]];
    [profileLocationTextFieldView addSubview:locationTextField];
    
    UILabel *emailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 196.0f, 110.0f, 14.0f)];
    [emailAddressLabel setText:@"Email Address:"];
    [emailAddressLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [emailAddressLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [emailAddressLabel setTextAlignment:NSTextAlignmentLeft];
    [emailAddressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:emailAddressLabel];
    
    UIView * profileEmailTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 214.0f, 280.0f, 38.0f)];
    [profileEmailTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileEmailTextFieldView];
    
    emailAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [emailAddressTextField setBorderStyle:UITextBorderStyleNone];
    [emailAddressTextField setEnabled:NO];
    [emailAddressTextField setText:[NSString stringWithFormat:@"%@", emailAddress]];
    [emailAddressTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [emailAddressTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [emailAddressTextField setBackgroundColor:[UIColor clearColor]];
    [profileEmailTextFieldView addSubview:emailAddressTextField];
    
    UILabel *interestLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 262.0f, 110.0f, 14.0f)];
    [interestLabel setText:@"Interests:"];
    [interestLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [interestLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [interestLabel setTextAlignment:NSTextAlignmentLeft];
    [interestLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:interestLabel];
    
    UIView * profileInterestsLabelView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 280.0f, 280.0f, 240.0f)];
    [profileInterestsLabelView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileInterestsLabelView];
    
    interestsTextView = [[UITextView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 240.0f)];
    [interestsTextView setEditable:NO];
    [interestsTextView setText:[NSString stringWithFormat:@"%@", interests]];
    [interestsTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [interestsTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [interestsTextView setBackgroundColor:[UIColor clearColor]];
    [profileInterestsLabelView addSubview:interestsTextView];
}

- (void)editProfile
{
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [locationTextField setEnabled:YES];
    [emailAddressTextField setEnabled:YES];
    [interestsTextView setEditable:YES];
}

- (void)saveProfile
{
    self.navigationItem.rightBarButtonItem = editButtonItem;
    
    [locationTextField setEnabled:NO];
    [emailAddressTextField setEnabled:NO];
    [interestsTextView setEditable:NO];
    
    if (emailAddressTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter an email address." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    } else if (locationTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter your location." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    } else if (emailAddressTextField.text.length && locationTextField.text.length > 0) {
        [currentUser setObject:emailAddressTextField.text forKey:@"userEmailAddress"];
        [currentUser setObject:locationTextField.text forKey:@"userCurrentLocation"];
        [currentUser setObject:interestsTextView.text forKey:@"userInterests"];
        [currentUser saveEventually];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
