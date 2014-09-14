//
//  ContactFriendViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/13/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "ContactFriendViewController.h"
#import "SWRevealViewController.h"
#import "ContactUsViewController.h"
#import <Parse/Parse.h>

@interface ContactFriendViewController ()

@property (nonatomic, strong) UIBarButtonItem *saveButtonItem;
@property (nonatomic, strong) UIBarButtonItem *editButtonItem;
@property (nonatomic, strong) NSString *sponsorsName;
@property (nonatomic, strong) NSString *sponsorsPhoneNumber;
@property (nonatomic, strong) NSString *friendsName;
@property (nonatomic, strong) NSString *friendsNumber;
@property (nonatomic, strong) NSString *profileId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation ContactFriendViewController

@synthesize sponsorTextField, friendsPhoneNumberTextField, sponsorNumberTextField, friendsNameTextField, sponsorsName, sponsorsPhoneNumber, friendsName, friendsNumber, currentUser, saveButtonItem, editButtonItem, profileId, username;

BOOL interestsBool;
BOOL matches;
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
    editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editFriends)];
    [editButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0f]} forState:UIControlStateNormal];
    [editButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.rightBarButtonItem = editButtonItem;
    
    saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveFriends)];
    [saveButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0f]} forState:UIControlStateNormal];
    [saveButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    
    [self setFriendsView];
    
    currentUser = [PFUser currentUser];
    username = [currentUser username];
    
    PFQuery *query = [PFQuery queryWithClassName:@"profilesList"];
    [query whereKey:@"profileUserName" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                profileId = object.objectId;
                sponsorTextField.text = object[@"sponsorName"];
                sponsorNumberTextField.text = object[@"sponsorNumber"];
                friendsNameTextField.text = object[@"friendsName"];
                friendsPhoneNumberTextField.text = object [@"friendsNumber"];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)setFriendsView
{
    UILabel *sponsorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 220.0f, 14.0f)];
    [sponsorLabel setText:@"My Sponsor's Name:"];
    [sponsorLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [sponsorLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [sponsorLabel setTextAlignment:NSTextAlignmentLeft];
    [sponsorLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:sponsorLabel];
    
    UIView * sponsorTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 96.0f, 280.0f, 38.0f)];
    [sponsorTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:sponsorTextFieldView];
    
    sponsorTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [sponsorTextField setBorderStyle:UITextBorderStyleNone];
    [sponsorTextField setEnabled:NO];
    [sponsorTextField setDelegate:self];
    [sponsorTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [sponsorTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [sponsorTextField setBackgroundColor:[UIColor clearColor]];
    [sponsorTextFieldView addSubview:sponsorTextField];
    
    UILabel *sponsorPhoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 136.0f, 220.0f, 14.0f)];
    [sponsorPhoneNumberLabel setText:@"My Sponsor's Phone Number:"];
    [sponsorPhoneNumberLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [sponsorPhoneNumberLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [sponsorPhoneNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [sponsorPhoneNumberLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:sponsorPhoneNumberLabel];
    
    UIView * sponsorNumberTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 152.0f, 280.0f, 38.0f)];
    [sponsorNumberTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:sponsorNumberTextFieldView];
    
    sponsorNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [sponsorNumberTextField setBorderStyle:UITextBorderStyleNone];
    [sponsorNumberTextField setEnabled:NO];
    [sponsorNumberTextField setDelegate:self];
    [sponsorNumberTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [sponsorNumberTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [sponsorNumberTextField setBackgroundColor:[UIColor clearColor]];
    [sponsorNumberTextFieldView addSubview:sponsorNumberTextField];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callSponsor:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [sponsorNumberTextFieldView addGestureRecognizer:tapGestureRecognizer];
    [sponsorNumberTextFieldView setUserInteractionEnabled:YES];
    
    UILabel *friendsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 192.0f, 220.0f, 14.0f)];
    [friendsNameLabel setText:@"Friend's Name:"];
    [friendsNameLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [friendsNameLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [friendsNameLabel setTextAlignment:NSTextAlignmentLeft];
    [friendsNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:friendsNameLabel];
    
    UIView * friendsNameTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 208.0f, 280.0f, 38.0f)];
    [friendsNameTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:friendsNameTextFieldView];
    
    friendsNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [friendsNameTextField setBorderStyle:UITextBorderStyleNone];
    [friendsNameTextField setEnabled:NO];
    [friendsNameTextField setDelegate:self];
    [friendsNameTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [friendsNameTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [friendsNameTextField setBackgroundColor:[UIColor clearColor]];
    [friendsNameTextFieldView addSubview:friendsNameTextField];
    
    UILabel *friendsPhoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 248.0f, 220.0f, 14.0f)];
    [friendsPhoneNumberLabel setText:@"Friend's Phone Number:"];
    [friendsPhoneNumberLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [friendsPhoneNumberLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [friendsPhoneNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [friendsPhoneNumberLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:friendsPhoneNumberLabel];
    
    UIView * friendsPhoneNumberLabelView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 264.0f, 280.0f, 38.0f)];
    [friendsPhoneNumberLabelView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:friendsPhoneNumberLabelView];
    
    friendsPhoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [friendsPhoneNumberTextField setEnabled:NO];
    [friendsPhoneNumberTextField setDelegate:self];
    [friendsPhoneNumberTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [friendsPhoneNumberTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [friendsPhoneNumberTextField setBackgroundColor:[UIColor clearColor]];
    [friendsPhoneNumberLabelView addSubview:friendsPhoneNumberTextField];
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callFriend:)];
    tapGestureRecognizer1.numberOfTapsRequired = 1;
    [friendsPhoneNumberLabelView addGestureRecognizer:tapGestureRecognizer1];
    [friendsPhoneNumberLabelView setUserInteractionEnabled:YES];
}

- (void)editFriends
{
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [sponsorTextField setEnabled:YES];
    [sponsorNumberTextField setEnabled:YES];
    [friendsNameTextField setEnabled:YES];
    [friendsPhoneNumberTextField setEnabled:YES];
}

- (void)saveFriends
{
    self.navigationItem.rightBarButtonItem = editButtonItem;
    
    [sponsorTextField setEnabled:NO];
    [sponsorNumberTextField setEnabled:NO];
    [friendsNameTextField setEnabled:NO];
    [friendsPhoneNumberTextField setEnabled:NO];
    
    if (sponsorTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter your sponsor's name." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    } else if (sponsorNumberTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter your sponsor's phone number." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    } else if (sponsorNumberTextField.text.length != 0){
        NSString *phoneNumber = sponsorNumberTextField.text;
        NSString *phoneRegex = @"^[1-9]{3}-[0-9]{3}-[0-9]{4}$";
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        matches = [test evaluateWithObject:phoneNumber];
        NSLog(@"Does it match? %hhd", matches);
        if (matches == NO) {
            NSLog(@"Does not match.");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter phone number correctly." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alertView show];
        } else if (matches == YES && sponsorTextField.text.length && sponsorNumberTextField.text.length > 0) {
            NSLog(@"Saving object.");
            PFQuery *query = [PFQuery queryWithClassName:@"profilesList"];
            [query getObjectInBackgroundWithId:profileId block:^(PFObject *userProfileSave, NSError *error) {
                userProfileSave[@"sponsorName"] = sponsorTextField.text;
                userProfileSave[@"sponsorNumber"] = sponsorNumberTextField.text;
                userProfileSave[@"friendsName"] = friendsNameTextField.text;
                userProfileSave[@"friendsNumber"] = friendsPhoneNumberTextField.text ;
                [userProfileSave saveEventually];
            }];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Friends Updated"
                                                            message:@"Friends Successfully Saved!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
    }
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

- (void)callSponsor:(id)sender
{
    NSString *sponsorNumber = sponsorNumberTextField.text;
    NSString *phoneRegex = @"^[1-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    matches = [test evaluateWithObject:sponsorNumber];
    
    if (matches == YES) {
        NSString *newString = [[sponsorNumber componentsSeparatedByCharactersInSet:
                                [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]]
                               componentsJoinedByString:@""];
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", newString];
        NSLog(@"Phone Number: %@", phoneNumber);
        NSURL *phoneURL = [NSURL URLWithString:phoneNumber];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Phone Call Error"
                                                        message:@"Error In Making Phone Call"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)callFriend:(id)sender
{
    NSString *sponsorNumber = friendsPhoneNumberTextField.text;
    NSString *phoneRegex = @"^[1-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    matches = [test evaluateWithObject:sponsorNumber];
    
    if (matches == YES) {
        NSString *newString = [[sponsorNumber componentsSeparatedByCharactersInSet:
                                [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]]
                               componentsJoinedByString:@""];
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", newString];
        NSLog(@"Phone Number: %@", phoneNumber);
        NSURL *phoneURL = [NSURL URLWithString:phoneNumber];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Phone Call Error"
                                                        message:@"Error In Making Phone Call"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
