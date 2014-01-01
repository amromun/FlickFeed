//
//  FKAuthViewController.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/24/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#import "FKAuthViewController.h"
#import "FlickrKit.h"
#import "CTMainViewController.h"
#import "CTAppDelegate.h"

@interface FKAuthViewController ()
@property (nonatomic, retain) FKDUNetworkOperation *authOp;
@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@end

@implementation FKAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];

	
	NSString *callbackURLString = @"flickfeed://auth";
	
	
	self.authOp = [[FlickrKit sharedFlickrKit] beginAuthWithCallbackURL:[NSURL URLWithString:callbackURLString] permission:FKPermissionDelete completion:^(NSURL *flickrLoginPageURL, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!error) {
				NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:flickrLoginPageURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
				[self.webView loadRequest:urlRequest];
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
			}
        });
	}];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
   
	
    NSURL *url = [request URL];
    
	    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
            return NO;
        }
    }
	
    return YES;
	
}


- (void) userAuthenticateCallback:(NSNotification *)notification {
	NSURL *callbackURL = notification.object;
    
    
    
    self.completeAuthOp = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!error) {
				//[self userLoggedIn:userName userID:userId];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woohoo" message:@"Login Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
                
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"flickrUserId"];
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"flickrUserName"];
                [[NSUserDefaults standardUserDefaults] setObject:fullName forKey:@"flickrFullName"];
                
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
			}
            
            UITabBarController *hVCt  = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentVc"];
            
            CTAppDelegate *appDelegate = (CTAppDelegate *)[[UIApplication sharedApplication]delegate];
            [UIView
             transitionWithView:appDelegate.window
             duration:0.5
             options:UIViewAnimationOptionTransitionCrossDissolve
             animations:^(void) {
                 BOOL oldState = [UIView areAnimationsEnabled];
                 
                 [UIView setAnimationsEnabled:NO];
                 
                 appDelegate.window.rootViewController = hVCt;
                 
                 [UIView setAnimationsEnabled:oldState];
             }
             completion:nil];

		});
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
