//
//  MyProfileViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#define kOFFSET_FOR_KEYBOARD_INTERESTS 60.0
#define kOFFSET_FOR_KEYBOARD_GOALS 210.0

#import "MyProfileViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface MyProfileViewController ()

@property (nonatomic, strong) UIBarButtonItem *saveButtonItem;
@property (nonatomic, strong) UIBarButtonItem *editButtonItem;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *interests;
@property (nonatomic, strong) NSString *goals;
@property (nonatomic, strong) NSString *profileId;
@property (nonatomic, strong) NSString *switchOn;
@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation MyProfileViewController

@synthesize profileEmailAddressLabel, profileInterestsLabel, profileLocationLabel, profileUsernameLabel, usernameTextField, interestsTextView, locationTextField, emailAddressTextField, username, emailAddress, location, interests, currentUser, saveButtonItem, editButtonItem, profileGoalsLabel, goalsTextView, goals, profileId, profileSwitch, switchOn;

BOOL interestsBool;
CGRect rect;

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
    [editButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0f]} forState:UIControlStateNormal];
    [editButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.rightBarButtonItem = editButtonItem;
    
    saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveProfile)];
    [saveButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0f]} forState:UIControlStateNormal];
    [saveButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    
    currentUser = [PFUser currentUser];
    username = [currentUser username];
    emailAddress = currentUser[@"userEmailAddress"];
    location = currentUser[@"userCurrentLocation"];
    interests = currentUser[@"userInterests"];
    goals = currentUser[@"userGoals"];
    
    NSLog(@"CURRENT USER: %@", username);
    NSLog(@"EMAIL ADDRESS: %@", emailAddress);
    NSLog(@"LOCATION: %@", location);
    
    [self setProfileView];
}

- (void)setProfileView
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
    [usernameTextField setEnabled:NO];
    [usernameTextField setDelegate:self];
    [usernameTextField setText:[NSString stringWithFormat:@"%@", username]];
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
    [locationTextField setEnabled:NO];
    [locationTextField setDelegate:self];
    
    if ([location isEqual:@""]){
        [locationTextField setPlaceholder:@"Ex. Denver, Colorado"];
    } else {
        [locationTextField setText:[NSString stringWithFormat:@"%@", location]];
    }
    
    [locationTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [locationTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [locationTextField setBackgroundColor:[UIColor clearColor]];
    [profileLocationTextFieldView addSubview:locationTextField];
    
    UILabel *emailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 192.0f, 110.0f, 14.0f)];
    [emailAddressLabel setText:@"Email Address:"];
    [emailAddressLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [emailAddressLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [emailAddressLabel setTextAlignment:NSTextAlignmentLeft];
    [emailAddressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:emailAddressLabel];
    
    UIView * profileEmailTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 208.0f, 280.0f, 38.0f)];
    [profileEmailTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileEmailTextFieldView];
    
    emailAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [emailAddressTextField setBorderStyle:UITextBorderStyleNone];
    [emailAddressTextField setEnabled:NO];
    [emailAddressTextField setDelegate:self];
    
    if ([emailAddress isEqual:@""]){
        [emailAddressTextField setPlaceholder:@"Ex. john.doe@email.com"];
    } else {
        [emailAddressTextField setText:[NSString stringWithFormat:@"%@", emailAddress]];
    }

    [emailAddressTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [emailAddressTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [emailAddressTextField setBackgroundColor:[UIColor clearColor]];
    [profileEmailTextFieldView addSubview:emailAddressTextField];
    
    UILabel *interestLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 248.0f, 110.0f, 14.0f)];
    [interestLabel setText:@"Interests:"];
    [interestLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [interestLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [interestLabel setTextAlignment:NSTextAlignmentLeft];
    [interestLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:interestLabel];
    
    UIView * profileInterestsLabelView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 264.0f, 280.0f, 66.0f)];
    [profileInterestsLabelView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileInterestsLabelView];
    
    interestsTextView = [[UITextView alloc] initWithFrame:CGRectMake(4.0f, 0.0f, 272.0f, 66.0f)];
    [interestsTextView setEditable:NO];
    [interestsTextView setDelegate:self];
    [interestsTextView setText:[NSString stringWithFormat:@"%@", interests]];
    [interestsTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [interestsTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [interestsTextView setBackgroundColor:[UIColor clearColor]];
    [profileInterestsLabelView addSubview:interestsTextView];
    
    UILabel *goalsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 332.0f, 110.0f, 14.0f)];
    [goalsLabel setText:@"Goals:"];
    [goalsLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [goalsLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [goalsLabel setTextAlignment:NSTextAlignmentLeft];
    [goalsLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:goalsLabel];
    
    UIView * profileGoalsLabelView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 348.0f, 280.0f, 158.0f)];
    [profileGoalsLabelView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileGoalsLabelView];
    
    goalsTextView = [[UITextView alloc] initWithFrame:CGRectMake(4.0f, 0.0f, 276.0f, 158.0f)];
    [goalsTextView setEditable:NO];
    [goalsTextView setDelegate:self];
    [goalsTextView setText:[NSString stringWithFormat:@"%@", goals]];
    [goalsTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [goalsTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [goalsTextView setBackgroundColor:[UIColor clearColor]];
    [profileGoalsLabelView addSubview:goalsTextView];
    
    UILabel *publicLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 528.0f, 200.0f, 20.0f)];
    [publicLabel setText:@"Make Profile Public"];
    [publicLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [publicLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [publicLabel setTextAlignment:NSTextAlignmentLeft];
    [publicLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:publicLabel];
    
    profileSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(248, 522, 0, 0)];
    
    PFQuery *query = [PFQuery queryWithClassName:@"profilesList"];
    [query whereKey:@"profileUserName" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d profile.", objects.count);
            for (PFObject *object in objects) {
                profileId = object.objectId;
                switchOn = object[@"profilePublic"];
                NSLog(@"Switch On Is: %@", switchOn);
                
                if ([switchOn isEqual:@"YES"]){
                    [[self profileSwitch] setOn:YES animated:YES];
                } else {
                    [[self profileSwitch] setOn:NO animated:YES];
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [profileSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [profileSwitch setEnabled:NO];
    [self.view addSubview:profileSwitch];
}

- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        NSLog(@"Switch is ON");
        switchOn = @"YES";
    } else{
        NSLog(@"Switch is OFF");
        switchOn = @"NO";
    }
}

- (void)editProfile
{
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [locationTextField setEnabled:YES];
    [emailAddressTextField setEnabled:YES];
    [interestsTextView setEditable:YES];
    [goalsTextView setEditable:YES];
    [profileSwitch setEnabled:YES];
}

- (void)saveProfile
{
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
        [currentUser setObject:goalsTextView.text forKey:@"userGoals"];
        [currentUser saveEventually];
        
        PFQuery *query = [PFQuery queryWithClassName:@"profilesList"];
        [query getObjectInBackgroundWithId:profileId block:^(PFObject *userProfileSave, NSError *error) {
            userProfileSave[@"profileCurrentLocation"] = locationTextField.text;
            userProfileSave[@"profileInterests"] = interestsTextView.text;
            userProfileSave[@"profileGoals"] = goalsTextView.text;
            userProfileSave[@"profilePublic"] = switchOn;
            NSLog(@"Switch On = %@", switchOn);
            [userProfileSave saveEventually];
        }];
        
        self.navigationItem.rightBarButtonItem = editButtonItem;
        
        [locationTextField setEnabled:NO];
        [emailAddressTextField setEnabled:NO];
        [interestsTextView setEditable:NO];
        [goalsTextView setEditable:NO];
        [profileSwitch setEnabled:NO];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile Updated"
                                                        message:@"Profile Successfully Saved!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)sender
{
    if ([sender isEqual:interestsTextView])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [saveButtonItem setEnabled:NO];
            interestsBool = YES;
            [self setViewMovedUp:YES];
        }
    } else if ([sender isEqual:goalsTextView])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [saveButtonItem setEnabled:NO];
            [interestsTextView setEditable:NO];
            interestsBool = NO;
            [self setViewMovedUp:YES];
        }
    }
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    rect = self.view.frame;
    
    if (interestsBool == YES){
        if (movedUp)
        {
            rect.origin.y -= kOFFSET_FOR_KEYBOARD_INTERESTS;
            rect.size.height += kOFFSET_FOR_KEYBOARD_INTERESTS;
        }
        else
        {
            rect.origin.y += kOFFSET_FOR_KEYBOARD_INTERESTS;
            rect.size.height -= kOFFSET_FOR_KEYBOARD_INTERESTS;
        }
    } else if (interestsBool == NO){
        if (movedUp)
        {
            rect.origin.y -= kOFFSET_FOR_KEYBOARD_GOALS;
            rect.size.height += kOFFSET_FOR_KEYBOARD_GOALS;
        }
        else
        {
            rect.origin.y += kOFFSET_FOR_KEYBOARD_GOALS;
            rect.size.height -= kOFFSET_FOR_KEYBOARD_GOALS;
        }
    }
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)sender shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ( [text isEqualToString:@"\n"] ) {
        [sender resignFirstResponder];
        [saveButtonItem setEnabled:YES];
        
        if ([sender isEqual:interestsTextView])
        {
            if  (self.view.frame.origin.y < 0)
            {
                interestsBool = YES;
                [self setViewMovedUp:NO];
            }
        } else if ([sender isEqual:goalsTextView])
        {
            if  (self.view.frame.origin.y < 0)
            {
                [interestsTextView setEditable:YES];
                interestsBool = NO;
                [self setViewMovedUp:NO];
            }
        }
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
