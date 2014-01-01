//
//  TextPopTest.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/31/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#import "TextPopTest.h"
#import "YIPopupTextView.h"

@interface TextPopTest ()
@property (nonatomic) YIPopupTextView* popupTextView;
@end

@implementation TextPopTest

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
    BOOL editable = YES;
    CGFloat statusBarHeight = 20;
    CGFloat defaultInset = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 30 : 15);
    
    UINavigationBar* navBar = self.navigationController.navigationBar;
    UITabBar* tabBar = self.tabBarController.tabBar;
    
    CGFloat navBarHeight = (navBar && !navBar.hidden ? navBar.bounds.size.height : 0);
    CGFloat tabBarHeight = (tabBar && !tabBar.hidden && !editable ? tabBar.bounds.size.height : 0);
    
    self.popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"input here"
                                        maxCount:1000
                                     buttonStyle:YIPopupTextViewButtonStyleRightCancelAndDone
                                 doneButtonColor:nil // default color
                                  textViewInsets:UIEdgeInsetsMake(defaultInset+statusBarHeight+navBarHeight,
                                                                  defaultInset,
                                                                  defaultInset+tabBarHeight,
                                                                  defaultInset)];
    
    self.popupTextView.delegate = self;
    self.popupTextView.caretShiftGestureEnabled = YES;   // default = NO
    
    self.popupTextView.editable = editable;                  // set editable=NO to show without keyboard
    [self.popupTextView showInView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
