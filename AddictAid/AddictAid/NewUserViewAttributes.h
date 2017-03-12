//
//  NewUserViewAttributes.h
//  AddictAid
//
//  Created by Justin Rowe on 3/12/17.
//  Copyright © 2017 Justin Rowe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewUserViewAttributes : NSObject <UITextFieldDelegate>

@property (strong, nonatomic) NSString *welcomeString;
@property (strong, nonatomic) NSString *loginString;
@property (strong, nonatomic) NSString *userString;

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) NSMutableArray *userViewArray;

-(NSMutableArray *)setUpNewUserView;

@end
