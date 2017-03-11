//
//  LoginViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "LoginViewController.h"
#import "NewUserViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import <AWSMobileHubHelper/AWSMobileHubHelper.h>
#import "LoginViewAttributes.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

LoginViewAttributes * setUpLogin;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    setUpLogin = [[LoginViewAttributes alloc] init];
    [setUpLogin setUpLoginView];
    [self addSubviews:[setUpLogin viewArray]];
    
    
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
	
    
}

- (void)addSubviews:(NSArray *)views
{
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIView class]]) {
            [self.view addSubview:view];
        }
    }
}

- (IBAction)newUser:(id)sender
{
    NewUserViewController * newUserViewController = [[NewUserViewController alloc] init];
    [self presentViewController:newUserViewController animated:YES completion:nil];
}

- (IBAction)skipLogin:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentMainViewController];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender
{
    [[setUpLogin usernameField] resignFirstResponder];
	[[setUpLogin passwordField] resignFirstResponder];
    
	[self processFieldEntries];
}

- (void)processFieldEntries {
	NSString *username = [[setUpLogin usernameField] text];
	NSString *password = [[setUpLogin passwordField] text];
	NSString *noUsernameText = @"username";
	NSString *noPasswordText = @"password";
	NSString *errorText = @"No ";
	NSString *errorTextJoin = @" or ";
	NSString *errorTextEnding = @" entered";
	BOOL textError = NO;
    
	if (username.length == 0 || password.length == 0) {
		textError = YES;
        
		if (password.length == 0) {
			[[setUpLogin usernameField] becomeFirstResponder];
		}
		if (username.length == 0) {
			[[setUpLogin passwordField] becomeFirstResponder];
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
