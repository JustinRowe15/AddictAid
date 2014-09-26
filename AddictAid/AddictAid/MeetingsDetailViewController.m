//
//  MeetingsDetailViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 9/25/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "MeetingsDetailViewController.h"

@interface MeetingsDetailViewController ()

@end

@implementation MeetingsDetailViewController

@synthesize selectedMeeting, detailMeetingTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"background5.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    } else {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"background4.png"] drawInRect:self.view.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    }
    
    //Set Definition TextView
    detailMeetingTextView = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 480.0f)];
    [detailMeetingTextView setTextColor:[UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f]];
    [detailMeetingTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [detailMeetingTextView setBackgroundColor:[UIColor clearColor]];
    [detailMeetingTextView setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:detailMeetingTextView];
    [self.detailMeetingTextView setText:selectedMeeting];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
