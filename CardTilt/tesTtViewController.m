//
//  tesTtViewController.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/31/13.

//

#import "tesTtViewController.h"
#import "FlickrKit.h"
#import "CommentCell.h"
#import "YIPopupTextView.h"
#import <QuartzCore/QuartzCore.h>

@interface tesTtViewController ()
@property (nonatomic, retain) FKFlickrNetworkOperation *getCommentsOp;
@property (nonatomic, retain) FKFlickrNetworkOperation *addCommentsOp;
@property (nonatomic) YIPopupTextView* popupTextView;
@end

@implementation tesTtViewController
@synthesize photoId ,commentDict , commentArr;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Close"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(done)];
    self.navigationItem.leftBarButtonItem = doneButton;
    UIBarButtonItem *addCommentButton = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCommenView)];
    self.navigationItem.rightBarButtonItem = addCommentButton;
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.center = self.view.center;
    indicator.layer.backgroundColor = [[UIColor colorWithWhite:0.0f alpha:0.5f] CGColor];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    
    FKFlickrPhotosCommentsGetList *commentList = [[FKFlickrPhotosCommentsGetList alloc]init];
    commentList.photo_id = photoId;
    commentList.per_page =@"25";
    self.getCommentsOp = [[FlickrKit sharedFlickrKit] call:commentList  completion:^(NSDictionary *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{

    
            if (response) {
				commentArr = [response valueForKeyPath:@"comments.comment"];
                [self.tableView reloadData ];
                 [indicator stopAnimating];
			} else {
				/*
                 Iterating over specific errors for each service
				 */
				switch (error.code) {
					case FKFlickrInterestingnessGetListError_ServiceCurrentlyUnavailable:
						
						break;
					default:
						break;
				}
                
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
    
        }
                       });
	}];
    

        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)reloadAfterComment{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.center = self.view.center;
    indicator.layer.backgroundColor = [[UIColor colorWithWhite:0.0f alpha:0.5f] CGColor];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    
    FKFlickrPhotosCommentsGetList *commentList = [[FKFlickrPhotosCommentsGetList alloc]init];
    commentList.photo_id = photoId;
    commentList.per_page =@"25";
    self.getCommentsOp = [[FlickrKit sharedFlickrKit] call:commentList  completion:^(NSDictionary *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if (response) {
				commentArr = [response valueForKeyPath:@"comments.comment"];
                [self.tableView reloadData ];
                [indicator stopAnimating];
			} else {
				/*
                 Iterating over specific errors for each service
				 */
				switch (error.code) {
					case FKFlickrInterestingnessGetListError_ServiceCurrentlyUnavailable:
						
						break;
					default:
						break;
				}
                
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
                
            }
        });
	}];

}

-(void)showCommenView{
    BOOL editable = YES;
    CGFloat statusBarHeight = 20;
    CGFloat defaultInset = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 30 : 15);
    
    UINavigationBar* navBar = self.navigationController.navigationBar;
    UITabBar* tabBar = self.tabBarController.tabBar;
    
    CGFloat navBarHeight = (navBar && !navBar.hidden ? navBar.bounds.size.height : 0);
    CGFloat tabBarHeight = (tabBar && !tabBar.hidden && !editable ? tabBar.bounds.size.height : 0);
    
    self.popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Comment Here"
                                                             maxCount:1000
                                                          buttonStyle:YIPopupTextViewButtonStyleLeftCancelRightDone
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

-(void)sendComment:(NSString*)text{
    FKFlickrPhotosCommentsAddComment *addPhotoComment = [[FKFlickrPhotosCommentsAddComment alloc]init];
    addPhotoComment.photo_id = photoId;
        addPhotoComment.comment_text = text;

    self.addCommentsOp = [[FlickrKit sharedFlickrKit] call:addPhotoComment completion:^(NSDictionary *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response) {
                              [self reloadAfterComment];
            } else {
                /*
                 Iterating over specific errors for each service
                 */
                switch (error.code) {
                    case FKFlickrPhotosCommentsAddCommentError_UserNotLoggedInOrInsufficientPermissions:
                    {
                        NSString *h = error.localizedFailureReason;
                        break;}
                    default:
                        break;
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            }
            
            
        });
    }];

}

- (void)popupTextView:(YIPopupTextView *)textView willDismissWithText:(NSString *)text cancelled:(BOOL)cancelled
{
   // NSLog(@"will dismiss: cancelled=%d",cancelled);
   // self.textView.text = text;
   
    if(!cancelled){
        [self sendComment:text];
    }
    
   // _popupTextView = nil;
    
    [self setNeedsStatusBarAppearanceUpdate];
    }

-(void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return commentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"card2";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary * adict = commentArr[indexPath.row];
    NSString *realname =[adict valueForKey:@"realname"];
    
    if( [realname length] !=0)
    {
        cell.autho.text= [NSString stringWithFormat:@"  %@" ,[adict valueForKey:@"realname"]];
    }
    else
    {
        cell.autho.text= [NSString stringWithFormat:@"  %@" ,[adict valueForKey:@"authorname"]];
        
    }
    
    cell.comment.text= [NSString stringWithFormat:@"  %@", [adict valueForKey:@"_content"]];
    cell.comment.layer.cornerRadius = 8;
    
   // NSDictionary* comment = commentsDict[0];
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
