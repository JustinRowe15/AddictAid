//
//  DefinitionDetailViewController.m
//  AddictAid
//
//  Created by Justin Rowe on 8/28/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "DefinitionDetailViewController.h"
#import "NSDictionary+Data.h"

@interface DefinitionDetailViewController ()

@end

@implementation DefinitionDetailViewController

@synthesize detailDefinitionTextView, detailDefinition;

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
    detailDefinitionTextView = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 170.0f, 280.0f)];
    [detailDefinitionTextView setTextColor:[UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f]];
    [detailDefinitionTextView setFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [detailDefinitionTextView setBackgroundColor:[UIColor clearColor]];
    [detailDefinitionTextView setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:detailDefinitionTextView];
    [self.detailDefinitionTextView setText:detailDefinition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
