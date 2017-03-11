//
//  LoginViewAttributes.m
//  AddictAid
//
//  Created by Justin Rowe on 3/11/17.
//  Copyright © 2017 Justin Rowe. All rights reserved.
//

#import "LoginViewAttributes.h"

@implementation LoginViewAttributes

@synthesize welcomeString, loginString, userString, forgotString, welcomeLabel, loginLabel, userLabel, forgotLabel, loginButton, usernameField, passwordField, guestString, guestLabel, viewArray;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)setUpLoginView
{
    viewArray = [NSMutableArray array];
    
    //Set View Strings
    welcomeString = @"Welcome To AddictAid.";
    loginString = @"Please Log In To Your Account";
    userString = @"New user?  Click here.";
    guestString = @"Skip login as guest? Click here.";
    
    //Set Welcome Label Attributes
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 40.0, 270.0, 50.0)];
    [welcomeLabel setText:welcomeString];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    [welcomeLabel setNumberOfLines:1];
    [welcomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [welcomeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [welcomeLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:24]];
    //[self.view addSubview:welcomeLabel];
    
    //Setting colors in Welcome Label
    NSMutableAttributedString * welcomeStr = [[NSMutableAttributedString alloc] initWithString:welcomeString];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] range:NSMakeRange(0,11)];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:149.0/255.0 green:213.0/255.0 blue:230.0/255.0 alpha:1] range:NSMakeRange(11,9)];
    [welcomeLabel setAttributedText:welcomeStr];
    [viewArray addObject:welcomeLabel];
    
    // Set Login Label Attributes
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 80.0, 270.0, 50.0)];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [loginLabel setNumberOfLines:1];
    [loginLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [loginLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [loginLabel setText:loginString];
    //[self.view addSubview:loginLabel];
    [viewArray addObject:loginLabel];
    
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
    [viewArray addObject:usernameField];
    //[self.view addSubview:usernameField];
    
    //Set Password Text Field
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(35.0, 204.0, 250.0, 50.0)];
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    NSAttributedString *passwordStr = [[NSAttributedString alloc] initWithString:@"Enter Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    passwordField.attributedPlaceholder = passwordStr;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.secureTextEntry = YES;
    passwordField.delegate = self;
    [viewArray addObject:passwordField];
    //[self.view addSubview:passwordField];
    
    // Set New User Label Attributes
    userLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 358.0, 270.0, 20.0)];
    [userLabel setTextAlignment:NSTextAlignmentCenter];
    [userLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [userLabel setNumberOfLines:1];
    [userLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [userLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [userLabel setText:userString];
    //[self.view addSubview:userLabel];
    
    //Setting colors in User Label
    NSMutableAttributedString * userStr = [[NSMutableAttributedString alloc] initWithString:userString];
    [userStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] range:NSMakeRange(0,10)];
    [userStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:149.0/255.0 green:213.0/255.0 blue:230.0/255.0 alpha:1] range:NSMakeRange(10,11)];
    [userLabel setAttributedText:userStr];
    [viewArray addObject:userLabel];
    
    // Set Guest Label Attributes
    guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 396.0, 290.0, 20.0)];
    [guestLabel setTextAlignment:NSTextAlignmentCenter];
    [guestLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [guestLabel setNumberOfLines:1];
    [guestLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [guestLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [guestLabel setText:guestString];
    //[self.view addSubview:guestLabel];
    
    //Setting colors in Guest Label
    NSMutableAttributedString * guestStr = [[NSMutableAttributedString alloc] initWithString:guestString];
    [guestStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] range:NSMakeRange(0,21)];
    [guestStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:149.0/255.0 green:213.0/255.0 blue:230.0/255.0 alpha:1] range:NSMakeRange(21,10)];
    [guestLabel setAttributedText:guestStr];
    [viewArray addObject:guestLabel];
    
    //Log In Button Attributes
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(25.0, 284.0, 270.0, 50.0)];
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    loginButton.backgroundColor = [UIColor colorWithRed:196.0/255.0 green:47.0/255.0 blue:40.0/255.0 alpha:1];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.view addSubview:loginButton];
    [viewArray addObject:loginButton];
}

@end
