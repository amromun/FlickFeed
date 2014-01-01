//
//  CTAppDelegate.h
//  
//

#import <UIKit/UIKit.h>
#import "FlickrKit.h"
#import "SplashViewController.h"

@interface CTAppDelegate : UIResponder <UIApplicationDelegate , UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SplashViewController *SPV;
@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UITabBarController *tabController;
@end
