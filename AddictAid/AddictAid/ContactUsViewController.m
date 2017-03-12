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
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:revealController action:@selector(revealToggle:)];
    [revealButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 110.0f, 14.0f)];
    [nameLabel setText:@"Name:"];
    [nameLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [nameLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:nameLabel];
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 96.0f, 280.0f, 38.0f)];
    [nameTextField setTextColor:[UIColor blackColor]];
    [nameTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [nameTextField setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    nameTextField.delegate = self;
    [self.view addSubview:nameTextField];
    
    emailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 136.0f, 110.0f, 14.0f)];
    [emailAddressLabel setText:@"Email Address:"];
    [emailAddressLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [emailAddressLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [emailAddressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:emailAddressLabel];
    
    emailAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 152.0f, 280.0f, 38.0f)];
    [emailAddressTextField setTextColor:[UIColor blackColor]];
    [emailAddressTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [emailAddressTextField setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    emailAddressTextField.delegate = self;
    [self.view addSubview:emailAddressTextField];
    
    commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 192.0f, 110.0f, 14.0f)];
    [commentsLabel setText:@"Comments:"];
    [commentsLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [commentsLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [commentsLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:commentsLabel];
    
    commentsTextField = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, 208.0f, 280.0f, 280.0f)];
    [commentsTextField setTextColor:[UIColor blackColor]];
    [commentsTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [commentsTextField setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    commentsTextField.delegate = self;
    [self.view addSubview:commentsTextField];
    
    sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendButton setFrame:CGRectMake(20.0, 500.0, 280.0, 50.0)];
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ( [text isEqualToString:@"\n"] ) {
        [textView resignFirstResponder];
    }
    
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
