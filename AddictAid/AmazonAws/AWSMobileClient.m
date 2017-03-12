//
//  AWSMobileHubClient.m
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
//
//
#import "AWSMobileClient.h"
#import "AWSConfiguration.h"
#import <AWSMobileHubHelper/AWSMobileHubHelper.h>

@interface AWSMobileClient ()

@property (nonatomic) BOOL initialized;

@end

@implementation AWSMobileClient

- (instancetype)init {
    AWSLogDebug(@"init");
    self = [super init];
    _initialized = NO;
    [AWSLogger defaultLogger].logLevel = AWSLogLevelInfo;
    return self;
}

- (void)dealloc {
    // Should never get called
    AWSLogError(@"Dealloc called on singleton AWSMobileClient.");
}

#pragma mark Singleton Methods

+ (instancetype)sharedInstance {
    static AWSMobileClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

#pragma mark AppDelegate Methods

- (BOOL)didFinishLaunching:(UIApplication *)application
              withOptions:(NSDictionary *)launchOptions {
    AWSLogDebug(@"didFinishLaunching:withOptions:");
    
    // Register the sign in provider instances with their unique identifier

    // setup cognito user pool
    [self setupUserPool];
    
    BOOL didFinishLaunching = [[AWSIdentityManager defaultIdentityManager] interceptApplication:application
                                                                  didFinishLaunchingWithOptions:launchOptions];

    if (!_initialized) {
        [[AWSIdentityManager defaultIdentityManager] resumeSessionWithCompletionHandler:^(id result, NSError *error) {
            NSLog(@"result = %@, error = %@", result, error);
        }];
        _initialized = YES;
    }

    return didFinishLaunching;
}

- (BOOL)withApplication:(UIApplication *)application
               withURL:(NSURL *)url
 withSourceApplication:(NSString *)sourceApplication
        withAnnotation:(id)annotation {
    AWSLogDebug(@"withApplication:withURL:...");
    
    [[AWSIdentityManager defaultIdentityManager] interceptApplication:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    
    if (!_initialized) {
        _initialized = YES;
    }

    return NO;
}

#pragma mark - AWS Methods

- (void)setupUserPool {
    // register your user pool configuration
    [AWSCognitoUserPoolsSignInProvider setupUserPoolWithId:AWSCognitoUserPoolId
                        cognitoIdentityUserPoolAppClientId:AWSCognitoUserPoolClientId
                    cognitoIdentityUserPoolAppClientSecret:AWSCognitoUserPoolClientSecret
                                                    region:AWSCognitoUserPoolRegion
     ];
    
    [[AWSSignInProviderFactory sharedInstance] registerAWSSignInProvider:[AWSCognitoUserPoolsSignInProvider sharedInstance]
                                                                  forKey:AWSCognitoUserPoolsSignInProviderKey];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
};


@end
