//
//  CustomTabBarController.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/28/13.
//  
//

#import "CustomTabBarController.h"
#import "CTAppDelegate.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

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
    
    
    CTAppDelegate   *appDelegate = (CTAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.delegate = appDelegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
