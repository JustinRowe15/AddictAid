//
//  UserDetailViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface UserDetailViewController : UIViewController

@property (nonatomic, strong) PFObject *recievedUser;

@property (nonatomic, strong) UILabel *profileUsernameLabel;
@property (nonatomic, strong) UILabel *profileLocationLabel;
@property (nonatomic, strong) UILabel *profileInterestsLabel;
@property (nonatomic, strong) UILabel *profileGoalsLabel;

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *locationTextField;
@property (nonatomic, strong) UITextView *interestsTextView;
@property (nonatomic, strong) UITextView *goalsTextView;

@property (nonatomic, strong) NSString *userNameString;

@end
