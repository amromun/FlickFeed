//
//  SplashViewController.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/24/13.

//

#import "SplashViewController.h"
#import "CTAppDelegate.h"
#import "CTMainViewController.h"
#import "FKAuthViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)signinWeb:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   
    
    
    self.checkAuthOp = [[FlickrKit sharedFlickrKit] checkAuthorizationOnCompletion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        		dispatch_async(dispatch_get_main_queue(), ^{
        			if (!error) {

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
                        
                
        			} else {
                        
                        self.lblsign.hidden = false;
                        self.btnsign.hidden = false;
                        

                    }
                });
        	}];

    
    
}

- (IBAction)viewLogin:(id)sender {
    FKAuthViewController *fVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"webv"];
    
    CTAppDelegate *appDelegate = (CTAppDelegate *)[[UIApplication sharedApplication]delegate];
    [UIView
     transitionWithView:appDelegate.window
     duration:0.5
     options:UIViewAnimationOptionTransitionCrossDissolve
     animations:^(void) {
         BOOL oldState = [UIView areAnimationsEnabled];
         
         [UIView setAnimationsEnabled:NO];
         
         appDelegate.window.rootViewController = fVC;
         
         [UIView setAnimationsEnabled:oldState];
     }
     completion:nil];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
