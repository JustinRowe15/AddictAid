//
//  HomeViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *soberLabel;
@property (nonatomic, strong) UILabel *goalsTitleLabel;
@property (nonatomic, strong) UITextView *goalsTextView;
@property (nonatomic, strong) NSString *sobrietyDate;
@property (nonatomic, strong) NSDate *date1;

@end
