//
//  NewUserViewAttributes.m
//  AddictAid
//
//  Created by Justin Rowe on 3/12/17.
//  Copyright © 2017 Justin Rowe. All rights reserved.
//

#import "NewUserViewAttributes.h"

@implementation NewUserViewAttributes

@synthesize welcomeString, loginString, userString, welcomeLabel, loginLabel, userLabel, loginButton, usernameField, passwordField, userViewArray;

-(NSMutableArray *)setUpNewUserView
{
    userViewArray = [NSMutableArray array];
    
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
    
    //Log In Button Attributes
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(25.0, 284.0, 270.0, 50.0)];
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    loginButton.backgroundColor = [UIColor colorWithRed:196.0/255.0 green:47.0/255.0 blue:40.0/255.0 alpha:1];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userViewArray addObjectsFromArray:@[welcomeString, loginString, welcomeLabel, loginLabel, usernameField, passwordField, loginButton]];
    
    return userViewArray;
};

@end
