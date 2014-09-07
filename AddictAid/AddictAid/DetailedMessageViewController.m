//
//  DetailedMessageViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "DetailedMessageViewController.h"

@interface DetailedMessageViewController ()

@end

@implementation DetailedMessageViewController

@synthesize usernameTextField, subjectTextField, messageTextView;

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
    
    [self showMessageView];
}

- (void)showMessageView
{
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 110.0f, 14.0f)];
    [usernameLabel setText:@"From:"];
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
    [messageTextView setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [messageTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [messageTextView setBackgroundColor:[UIColor clearColor]];
    [messageTextFieldView addSubview:messageTextView];
    
    if(self.recievedMessage)
    {
        NSString * objectUserName = [self.recievedMessage objectForKey:@"messageSender"];
        [usernameTextField setText:objectUserName];
        [usernameTextField setEnabled:NO];
        
        NSString * objectUserSubject = [self.recievedMessage objectForKey:@"messageSubject"];
        [subjectTextField setText:objectUserSubject];
        [subjectTextField setEnabled:NO];
        
        NSString * objectUserMessage = [self.recievedMessage objectForKey:@"messageBody"];
        [messageTextView setText:objectUserMessage];
        [messageTextView setEditable:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
