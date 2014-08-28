//
//  SidebarTableViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SidebarTableViewController : UITableViewController

@property (nonatomic, strong) PFUser *currentUser;

@end
