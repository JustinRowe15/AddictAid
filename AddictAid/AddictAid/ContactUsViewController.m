//
//  ContactUsViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SWRevealViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

@synthesize nameLabel, emailAddressLabel, commentsLabel, nameTextField, emailAddressTextField, commentsTextField, sendButton;

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
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 280.0f, 20.0f)];
    [nameLabel setText:@"Name"];
    [nameLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [nameLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:nameLabel];
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 110.0f, 280.0f, 30.0f)];
    [nameTextField setTextColor:[UIColor blackColor]];
    [nameTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [nameTextField setBackgroundColor:[UIColor whiteColor]];
    nameTextField.delegate = self;
    [self.view addSubview:nameTextField];
    
    emailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 150.0f, 280.0f, 20.0f)];
    [emailAddressLabel setText:@"Email Address"];
    [emailAddressLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [emailAddressLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [emailAddressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:emailAddressLabel];
    
    emailAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 180.0f, 280.0f, 30.0f)];
    [emailAddressTextField setTextColor:[UIColor blackColor]];
    [emailAddressTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [emailAddressTextField setBackgroundColor:[UIColor whiteColor]];
    emailAddressTextField.delegate = self;
    [self.view addSubview:emailAddressTextField];
    
    commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 220.0f, 280.0f, 20.0f)];
    [commentsLabel setText:@"Comments"];
    [commentsLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [commentsLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [commentsLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:commentsLabel];
    
    commentsTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 250.0f, 280.0f, 160.0f)];
    [commentsTextField setTextColor:[UIColor blackColor]];
    [commentsTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [commentsTextField setBackgroundColor:[UIColor whiteColor]];
    commentsTextField.delegate = self;
    [self.view addSubview:commentsTextField];
    
    sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendButton setFrame:CGRectMake(20.0, 430.0, 280.0, 50.0)];
    [sendButton setTitle:@"Send Message" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    sendButton.backgroundColor = [UIColor colorWithRed:196.0/255.0 green:47.0/255.0 blue:40.0/255.0 alpha:1];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)done:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank You"
                                                    message:@"Message Sent Successfully!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
