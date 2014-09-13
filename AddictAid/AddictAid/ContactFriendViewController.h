//
//  ContactFriendViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/13/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactFriendViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *sponsorTextField;
@property (nonatomic, strong) UITextField *sponsorNumberTextField;
@property (nonatomic, strong) UITextField *friendsNameTextField;
@property (nonatomic, strong) UITextField *friendsPhoneNumberTextField;

@end
