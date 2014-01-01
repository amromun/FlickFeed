//
//  SplashViewController.h
//  FlickFeed
//
//  Created by Amro Munajjed on 12/24/13.
//  
//

#import <UIKit/UIKit.h>
#import "FlickrKit.h"

@interface SplashViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnsign;
@property (weak, nonatomic) IBOutlet UILabel *lblsign;
@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@end
