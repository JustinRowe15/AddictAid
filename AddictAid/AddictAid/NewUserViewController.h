//
//  NewUserViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString *welcomeString;
@property (strong, nonatomic) NSString *loginString;
@property (strong, nonatomic) NSString *userString;
@property (strong, nonatomic) NSString *forgotString;

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UILabel *forgotLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end
