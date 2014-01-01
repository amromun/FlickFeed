//
//  MainViewController.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/24/13.
// 
//

#import "MainViewController.h"
#import "FlickrKit.h"
#import "FKAuthViewController.h"

@interface MainViewController ()
@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@property (nonatomic, retain) NSString *userID;
@end

@implementation MainViewController

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
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];
	
   
	self.checkAuthOp = [[FlickrKit sharedFlickrKit] checkAuthorizationOnCompletion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!error) {
				[self userLoggedIn:userName userID:userId];
			} else {
				[self userLoggedOut];
			}
        });
	}];
}
- (IBAction)authButtonPressed:(id)sender {
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
		[[FlickrKit sharedFlickrKit] logout];
		[self userLoggedOut];
	} else {
        
        FKAuthViewController *authView = [self.storyboard instantiateViewControllerWithIdentifier:@"webv"];

        
        
		//FKAuthViewController *authView = [[FKAuthViewController alloc] init];
		[self.navigationController pushViewController:authView animated:YES];
	}
}


- (void) userAuthenticateCallback:(NSNotification *)notification {
	NSURL *callbackURL = notification.object;
    self.completeAuthOp = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!error) {
				[self userLoggedIn:userName userID:userId];
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
			}
			[self.navigationController popToRootViewControllerAnimated:YES];
		});
	}];
}

- (void) userLoggedIn:(NSString *)username userID:(NSString *)userID {
	//self.userID = userID;
	[self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
	//self.authLabel.text = [NSString stringWithFormat:@"You are logged in as %@", username];
}

- (void) userLoggedOut {
	[self.authButton setTitle:@"Login" forState:UIControlStateNormal];
	//self.authLabel.text = @"Login to flickr";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
