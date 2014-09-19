//
//  DaysTableViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 9/18/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaysTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) UIImageView *backgroundImageView;

@end
