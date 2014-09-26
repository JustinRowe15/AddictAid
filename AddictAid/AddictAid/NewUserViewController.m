//
//  NewUserViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "NewUserViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface NewUserViewController ()

@end

@implementation NewUserViewController

@synthesize welcomeString, loginString, userString, forgotString, welcomeLabel, loginLabel, userLabel, forgotLabel, loginButton, usernameField, passwordField;

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
    
    //Setting background image here
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"welcome5.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    } else {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"welcome4.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    }
	
    //Set View Strings
    welcomeString = @"Welcome To AddictAid.";
    loginString = @"Please Set Username and Password";
    
    //Set Welcome Label Attributes
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 40.0, 270.0, 50.0)];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    [welcomeLabel setNumberOfLines:1];
    [welcomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [welcomeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [welcomeLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:24]];
    [self.view addSubview:welcomeLabel];
    
    //Setting colors in Welcome Label
    NSMutableAttributedString * welcomeStr = [[NSMutableAttributedString alloc] initWithString:welcomeString];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] range:NSMakeRange(0,11)];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:149.0/255.0 green:213.0/255.0 blue:230.0/255.0 alpha:1] range:NSMakeRange(11,9)];
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
    NSAttributedString *usernameStr = [[NSAttributedString alloc] initWithString:@"Enter Username" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    usernameField.attributedPlaceholder = usernameStr;
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
    passwordField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    NSAttributedString *passwordStr = [[NSAttributedString alloc] initWithString:@"Enter Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    passwordField.attributedPlaceholder = passwordStr;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.secureTextEntry = YES;
    passwordField.delegate = self;
    [self.view addSubview:passwordField];
    
    //Log In Button Attributes
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(25.0, 284.0, 270.0, 50.0)];
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    loginButton.backgroundColor = [UIColor colorWithRed:196.0/255.0 green:47.0/255.0 blue:40.0/255.0 alpha:1];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
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
    
    PFUser *user = [PFUser user];
	user.username = username;
	user.password = password;
    user[@"userEmailAddress"] = @"";
    user[@"userCurrentLocation"] = @"";
    user[@"userInterests"] = @"";
    user[@"userGoals"] = @"";
    user[@"userStartDate"] = @"";
    
    PFObject *userProfileSave = [PFObject objectWithClassName:@"profilesList"];
    userProfileSave[@"friendsName"] = @"";
    userProfileSave[@"friendsNumber"] = @"";
    userProfileSave[@"profileUserName"] = user.username;
    userProfileSave[@"profileCurrentLocation"] = @"";
    userProfileSave[@"profileInterests"] = @"";
    userProfileSave[@"profileGoals"] = @"";
    userProfileSave[@"sponsorName"] = @"";
    userProfileSave[@"sponsorNumber"] = @"";
    userProfileSave[@"profileSobrietyStartDate"] = @"";
    [userProfileSave saveEventually];
    
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
			[alertView show];
			// Bring the keyboard back up, because they'll probably need to change something.
			[usernameField becomeFirstResponder];
			return;
		}
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentMainViewController];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}];
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

@end
