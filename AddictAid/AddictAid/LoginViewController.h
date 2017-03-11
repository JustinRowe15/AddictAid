//
//  LoginViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) UIWindow *window;

- (IBAction)newUser:(id)sender;
- (IBAction)skipLogin:(id)sender;
- (IBAction)done:(id)sender;

@end
