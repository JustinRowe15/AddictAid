//
//  AboutAddTableViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/26/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutAddTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) UIImageView *backgroundImageView;

@end
