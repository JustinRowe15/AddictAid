//
//  ContactUsViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *emailAddressLabel;
@property (nonatomic, strong) UILabel *commentsLabel;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *emailAddressTextField;
@property (nonatomic, strong) UITextField *commentsTextField;

@property (nonatomic, strong) IBOutlet UIButton *sendButton;

@end
