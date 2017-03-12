//
//  ContactUserViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "ContactUserViewController.h"
#import <Parse/Parse.h>

@interface ContactUserViewController ()

@property (nonatomic, strong) UIBarButtonItem *sendButtonItem;
@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation ContactUserViewController

@synthesize usernameTextField, messageTextView, sendButtonItem, username, subjectTextField, currentUser;

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
    
    currentUser = [PFUser currentUser];
    
    //Setting Right Bar Button Label
    sendButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    [sendButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0f]} forState:UIControlStateNormal];
    [sendButtonItem setTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    self.navigationItem.rightBarButtonItem = sendButtonItem;
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 110.0f, 14.0f)];
    [usernameLabel setText:@"To:"];
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
    [usernameTextField setText:username];
    [usernameTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [usernameTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [usernameTextField setBackgroundColor:[UIColor clearColor]];
    [profileUsernameTextFieldView addSubview:usernameTextField];
    
    UILabel *subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 136.0f, 110.0f, 14.0f)];
    [subjectLabel setText:@"Subject:"];
    [subjectLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [subjectLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [subjectLabel setTextAlignment:NSTextAlignmentLeft];
    [subjectLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:subjectLabel];
    
    UIView * profileLocationTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 152.0f, 280.0f, 38.0f)];
    [profileLocationTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:profileLocationTextFieldView];
    
    subjectTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 38.0f)];
    [subjectTextField setBorderStyle:UITextBorderStyleNone];
    [subjectTextField setEnabled:YES];
    [subjectTextField setDelegate:self];
    [subjectTextField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [subjectTextField setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [subjectTextField setBackgroundColor:[UIColor clearColor]];
    [profileLocationTextFieldView addSubview:subjectTextField];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 196.0f, 110.0f, 14.0f)];
    [messageLabel setText:@"Message:"];
    [messageLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [messageLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
    [messageLabel setTextAlignment:NSTextAlignmentLeft];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:messageLabel];

    UIView * messageTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 214.0f, 280.0f, 320.0f)];
    [messageTextFieldView setBackgroundColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.7f]];
    [self.view addSubview:messageTextFieldView];
    
    messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 272.0f, 320.0f)];
    [messageTextView setEditable:YES];
    [messageTextView setDelegate:self];
    [messageTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [messageTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [messageTextView setBackgroundColor:[UIColor clearColor]];
    [messageTextFieldView addSubview:messageTextView];
}

- (void)sendMessage
{
    if (messageTextView.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter a message." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    } else if (subjectTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter a subject." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    } else {
        NSString *messages = @"messages";
        NSString *usernameClass = [NSString stringWithFormat:@"%@%@", username, messages];
        PFObject *sendUserMessage = [PFObject objectWithClassName:usernameClass];
        [sendUserMessage setObject:currentUser.username forKey:@"messageSender"];
        [sendUserMessage setObject:usernameTextField.text forKey:@"messageUserName"];
        [sendUserMessage setObject:subjectTextField.text forKey:@"messageSubject"];
        [sendUserMessage setObject:messageTextView.text forKey:@"messageBody"];
        [sendUserMessage saveEventually];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
