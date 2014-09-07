//
//  ContactUserViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUserViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *subjectTextField;
@property (nonatomic, strong) UITextView *messageTextView;

@end
