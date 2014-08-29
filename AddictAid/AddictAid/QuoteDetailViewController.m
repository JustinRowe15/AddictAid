//
//  QuoteDetailViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/28/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "QuoteDetailViewController.h"

@interface QuoteDetailViewController ()

@end

@implementation QuoteDetailViewController

@synthesize detailQuote, detailQuoteTextView;

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
    detailQuoteTextView = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 480.0f)];
    [detailQuoteTextView setTextColor:[UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f]];
    [detailQuoteTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [detailQuoteTextView setBackgroundColor:[UIColor clearColor]];
    [detailQuoteTextView setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:detailQuoteTextView];
    [self.detailQuoteTextView setText:detailQuote];
}

@end
