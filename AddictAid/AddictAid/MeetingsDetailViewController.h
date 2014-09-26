//
//  MeetingsDetailViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/25/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingsDetailViewController : UIViewController

@property (nonatomic, strong) NSString *selectedMeeting;
@property (strong, nonatomic) UITextView *detailMeetingTextView;

@end
