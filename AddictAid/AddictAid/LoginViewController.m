//
//  LoginViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "LoginViewController.h"
#import "NewUserViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize welcomeString, loginString, userString, forgotString, welcomeLabel, loginLabel, userLabel, forgotLabel, loginButton, usernameField, passwordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setting background image here
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"welcome5.png"] drawInRect:self.view.bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
	
    //Set View Strings
    welcomeString = @"Welcome To AddictAid.";
    loginString = @"Please Log In To Your Account";
    userString = @"New user?  Click here.";
    
    //Set Welcome Label Attributes
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 40.0, 270.0, 50.0)];
    [welcomeLabel setText:welcomeString];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    [welcomeLabel setNumberOfLines:1];
    [welcomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [welcomeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [welcomeLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:24]];
    [self.view addSubview:welcomeLabel];
    
    //Setting colors in Welcome Label
    NSMutableAttributedString * welcomeStr = [[NSMutableAttributedString alloc] initWithString:welcomeString];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] range:NSMakeRange(0,11)];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:140.0/255.0 green:169.0/255.0 blue:165.0/255.0 alpha:1] range:NSMakeRange(11,9)];
    [welcomeLabel setAttributedText:welcomeStr];
    
    // Set Login Label Attributes
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 80.0, 270.0, 50.0)];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [loginLabel setNumberOfLines:1];
    [loginLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [loginLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [loginLabel setText:loginString];
    [self.view addSubview:loginLabel];
    
    //Set Username Text Field
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(35.0, 140.0, 250.0, 50.0)];
    usernameField.borderStyle = UITextBorderStyleNone;
    usernameField.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    usernameField.placeholder = @"Enter Username";
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameField.keyboardType = UIKeyboardTypeDefault;
    usernameField.returnKeyType = UIReturnKeyDone;
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameField.delegate = self;
    [self.view addSubview:usernameField];
    
    //Set Password Text Field
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(35.0, 204.0, 250.0, 50.0)];
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    passwordField.placeholder = @"Enter Password";
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.delegate = self;
    [self.view addSubview:passwordField];
    
    // Set Login Label Attributes
    userLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 338.0, 270.0, 50.0)];
    [userLabel setTextAlignment:NSTextAlignmentCenter];
    [userLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [userLabel setNumberOfLines:1];
    [userLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [userLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [userLabel setText:userString];
    [self.view addSubview:userLabel];
    
    //Setting colors in Welcome Label
    NSMutableAttributedString * userStr = [[NSMutableAttributedString alloc] initWithString:userString];
    [userStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] range:NSMakeRange(0,10)];
    [userStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:140.0/255.0 green:169.0/255.0 blue:165.0/255.0 alpha:1] range:NSMakeRange(10,11)];
    [userLabel setAttributedText:userStr];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newUser:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [userLabel addGestureRecognizer:tapGestureRecognizer];
    [userLabel setUserInteractionEnabled:YES];
    
    //Log In Button Attributes
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(25.0, 284.0, 270.0, 50.0)];
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    loginButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:173.0/255.0 blue:239.0/255.0 alpha:1];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (IBAction)newUser:(id)sender
{
    NewUserViewController * newUserViewController = [[NewUserViewController alloc] init];
    [self presentViewController:newUserViewController animated:YES completion:nil];
}

- (IBAction)done:(id)sender
{
	[usernameField resignFirstResponder];
	[passwordField resignFirstResponder];
    
	[self processFieldEntries];
}

- (void)processFieldEntries {
	NSString *username = usernameField.text;
	NSString *password = passwordField.text;
	NSString *noUsernameText = @"username";
	NSString *noPasswordText = @"password";
	NSString *errorText = @"No ";
	NSString *errorTextJoin = @" or ";
	NSString *errorTextEnding = @" entered";
	BOOL textError = NO;
    
	if (username.length == 0 || password.length == 0) {
		textError = YES;
        
		if (password.length == 0) {
			[passwordField becomeFirstResponder];
		}
		if (username.length == 0) {
			[usernameField becomeFirstResponder];
		}
	}
    
	if (username.length == 0) {
		textError = YES;
		errorText = [errorText stringByAppendingString:noUsernameText];
	}
    
	if (password.length == 0) {
		textError = YES;
		if (username.length == 0) {
			errorText = [errorText stringByAppendingString:errorTextJoin];
		}
		errorText = [errorText stringByAppendingString:noPasswordText];
	}
    
	if (textError) {
		errorText = [errorText stringByAppendingString:errorTextEnding];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
	}
    
	[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        
		if (user) {
			[(AppDelegate*)[[UIApplication sharedApplication] delegate] presentMainViewController];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
		} else {
			UIAlertView *alertView = nil;
            
			if (error == nil) {
				alertView = [[UIAlertView alloc] initWithTitle:@"Couldn’t log in:\nThe username or password were wrong." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
			} else {
				alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
			}
			[alertView show];
			[usernameField becomeFirstResponder];
		}
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end