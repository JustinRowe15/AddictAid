//
//  HomeTableViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) NSString *daySelected;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchDisplayController;

@end
