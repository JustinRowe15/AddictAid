//
//  MyProfileViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UILabel *profileUsernameLabel;
@property (nonatomic, strong) UILabel *profileLocationLabel;
@property (nonatomic, strong) UILabel *profileEmailAddressLabel;
@property (nonatomic, strong) UILabel *profileInterestsLabel;
@property (nonatomic, strong) UILabel *profileGoalsLabel;

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *locationTextField;
@property (nonatomic, strong) UITextField *emailAddressTextField;
@property (nonatomic, strong) UITextField *startDateTextField;
@property (nonatomic, strong) UITextView *interestsTextView;
@property (nonatomic, strong) UITextView *goalsTextView;

@property (nonatomic, strong) UISwitch *profileSwitch;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end
