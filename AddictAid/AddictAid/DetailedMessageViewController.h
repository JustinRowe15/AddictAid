//
//  DetailedMessageViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/6/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailedMessageViewController : UIViewController

@property (nonatomic, strong) PFObject *recievedMessage;

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *subjectTextField;
@property (nonatomic, strong) UITextView *messageTextView;

@end
