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
#import "HomeViewController.h"
#import "SidebarTableViewController.h"
#import "Constants.h"
#import "AWSMobileClient.h"

@interface AppDelegate()<SWRevealViewControllerDelegate>

@end

@implementation AppDelegate

@synthesize filterDistance, currentLocation;
@synthesize revealViewController = _revealViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return [[AWSMobileClient sharedInstance] didFinishLaunching:application
                                                    withOptions:launchOptions];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Set Navigation Bar Text Attributes
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.750f]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:149.0f/255.0f green:213.0f/255.0f blue:230.0f/255.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:38.0f/255.0f alpha:1.0f],
                                                           NSShadowAttributeName:shadow,
                                                           NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:20]
                                                           }];
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:0.5f]];
    
	if ([userDefaults doubleForKey:defaultsFilterDistanceKey]) {
		filterDistance = [userDefaults doubleForKey:defaultsFilterDistanceKey];
	} else {
		self.filterDistance = 3000 * kAAFeetToMeters;
	}
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[AWSMobileClient sharedInstance] withApplication:application
                                                     withURL:url
                                       withSourceApplication:sourceApplication
                                              withAnnotation:annotation];
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
	HomeViewController *homeViewController = [[HomeViewController alloc] init];
    SidebarTableViewController * sideBarViewController = [[SidebarTableViewController alloc] init];
    
	homeViewController.title = @"Welcome to AddictAid";
    
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    UINavigationController *sideBarNavController = [[UINavigationController alloc] initWithRootViewController:sideBarViewController];
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
    [[AWSMobileClient sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
