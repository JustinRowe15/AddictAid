//
//  AppDelegate.m
//  AddictAid
//
//  Created by Justin Rowe on 8/23/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

static NSString * const defaultsFilterDistanceKey = @"filterDistance";
static NSString * const defaultsLocationKey = @"currentLocation";

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "HomeTableViewController.h"
#import "SidebarTableViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface AppDelegate()<SWRevealViewControllerDelegate>
@end

@implementation AppDelegate

@synthesize filterDistance, currentLocation;
@synthesize revealViewController = _revealViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Load Parse application ID into database for analytics tracking
    [Parse setApplicationId:@"nQdJZ7nnfvI7BVXFdv9vnSPMIn8bfj7VKq4xDk7c"
                  clientKey:@"l5mSFdBZqCCGyUSWQ6qZi2YuWbgSkTgYqqqtGdez"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Set Navigation Bar Text Attributes
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.750f]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:0.8f]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor colorWithRed:140.0f/255.0f green:169.0f/255.0f blue:165.0f/255.0f alpha:1.0f],
                                                           NSShadowAttributeName: shadow,
                                                           NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:20]
                                                           }];
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.5f]];
    
    // Desired search radius:
	if ([userDefaults doubleForKey:defaultsFilterDistanceKey]) {
		// use the ivar instead of self.accuracy to avoid an unnecessary write to NAND on launch.
		filterDistance = [userDefaults doubleForKey:defaultsFilterDistanceKey];
	} else {
		// if we have no accuracy in defaults, set it to 3000 feet.
		self.filterDistance = 3000 * kAAFeetToMeters;
	}
    
    //Check to see if user is logged in
	PFUser *currentUser = [PFUser currentUser];
	if (currentUser) {
		// User is logged in.  Skip straight to the main view.
		[self presentMainViewController];
	} else {
		// Not logged in.  Go to the welcome screen and have them log in or create an account.
		[self presentLoginViewController];
	}
    
    //Tracking Shara analytics in Parse
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)presentLoginViewController;
{
	// Go to the welcome screen and have them log in or create an account.
	self.loginViewController = [[LoginViewController alloc] init];
	self.loginViewController.title = @"Welcome to AddictAid";
    
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
	navController.navigationBarHidden = YES;
    
	self.viewController = navController;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        self.viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
	self.window.rootViewController = self.viewController;
}

-(void)presentMainViewController{
    // Go to the welcome screen and have them log in or create an account.
	HomeTableViewController *homeTableViewController = [[HomeTableViewController alloc] init];
    SidebarTableViewController * sideBarViewController = [[SidebarTableViewController alloc] init];
    
	homeTableViewController.title = @"AddictAid";
    
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeTableViewController];
    UINavigationController *sideBarNavController = [[UINavigationController alloc] initWithRootViewController:sideBarViewController     ];
	navController.navigationBarHidden = NO;
    sideBarNavController.navigationBarHidden = NO;
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:sideBarNavController frontViewController:navController];
    revealController.delegate = self;
    
	self.revealViewController = revealController;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        self.revealViewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
	self.window.rootViewController = self.revealViewController;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end