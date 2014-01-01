//
//  LocalViewController.m
//  CardTilt
//
//  Created by Amro Munajjed on 12/21/13.

//

#import "LocalViewController.h"
#import "CTCardCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MWPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "FlickrKit.h"
#import "NaviController.h"
#import "tesTtViewController.h"


@interface LocalViewController ()

@property (strong, nonatomic) NSArray *members;
@property (nonatomic, assign) CATransform3D initialTransformation;
@property (nonatomic, strong) NSMutableSet *shownIndexes;
@property (nonatomic,strong) NSMutableArray *photos;
@property (nonatomic, retain) FKFlickrNetworkOperation *todaysInterestingOp;


@end

@implementation LocalViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     //NSString *urlString = @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=83f49948118eb040840303b83ed21cfc&woe_id=23424938&extras=owner_name%2Curl_o%2Cd//ate_taken&per_page=35&format=json&nojsoncallback=1";
    
   // NSURL *url = [NSURL URLWithString:urlString];
    // 2. Get URLResponse string & parse JSON to Foundation objects.
    //   NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //
    
    
   // NSError *error;
   // NSData *data = [NSData dataWithContentsOfURL:url];
    //NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TeamMembers" ofType:@"json"]];
    //NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    //self.members = [[json objectForKey:@"photos"] objectForKey:@"photo"];
    
   // self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"8285_640x1136.jpg"]];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.center = self.view.center;
    indicator.layer.backgroundColor = [[UIColor colorWithWhite:0.0f alpha:0.5f] CGColor];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
	interesting.per_page = @"25";
    interesting.extras = @"description,owner_name,url_o,date_taken";
	self.todaysInterestingOp = [[FlickrKit sharedFlickrKit] call:interesting completion:^(NSDictionary *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (response) {
				//NSMutableArray *photoURLs = [NSMutableArray array];
//				for (NSDictionary *photoDictionary in [response valueForKeyPath:@"photos.photo"]) {
//					NSURL *url = [[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoDictionary];
//					[photoURLs addObject:url];
//				}
//				
//				FKPhotosViewController *fivePhotos = [[FKPhotosViewController alloc] initWithURLArray:photoURLs];
//				[self.navigationController pushViewController:fivePhotos animated:YES];
                self.members =[response valueForKeyPath:@"photos.photo"];
                [self.tableView reloadData];
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

    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    NSString *s = @"Pull to Refresh";
    NSMutableAttributedString *a = [[NSMutableAttributedString alloc] initWithString:@"Pull to Refresh"];
    [a addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [s length])];
    refreshControl.attributedTitle = a;
    
    //refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refreshControl addTarget:self action:@selector(updateList) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    //[self.tableView addSubview:refreshControl];
    
    self.refreshControl.layer.zPosition = self.tableView.backgroundView.layer.zPosition + 1;
    
    
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Old.png"]];
    
    CGFloat rotationAngleDegrees = -15;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPosition = CGPointMake(-20, -20);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPosition.x, offsetPosition.y, 0.0);
    _initialTransformation = transform;
    
    _shownIndexes = [NSMutableSet set];
}

- (void)updateList
{
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
	interesting.per_page = @"25";
    interesting.extras = @"owner_name,url_o,date_taken";
	self.todaysInterestingOp = [[FlickrKit sharedFlickrKit] call:interesting completion:^(NSDictionary *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (response) {
				//NSMutableArray *photoURLs = [NSMutableArray array];
                //				for (NSDictionary *photoDictionary in [response valueForKeyPath:@"photos.photo"]) {
                //					NSURL *url = [[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoDictionary];
                //					[photoURLs addObject:url];
                //				}
                //
                //				FKPhotosViewController *fivePhotos = [[FKPhotosViewController alloc] initWithURLArray:photoURLs];
                //				[self.navigationController pushViewController:fivePhotos animated:YES];
                self.members =[response valueForKeyPath:@"photos.photo"];
                [self.tableView reloadData];
                
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
    [self performSelector:@selector(updateTable) withObject:nil
               afterDelay:1];
}

- (void)updateTable
{
    
    [self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.shownIndexes containsObject:indexPath]) {
        [self.shownIndexes addObject:indexPath];
        
        UIView *card = [(CTCardCell* )cell mainView];
        
        card.layer.transform = self.initialTransformation;
        card.layer.opacity = 0.8;
        
        [UIView animateWithDuration:0.4 animations:^{
            
            
            card.layer.transform = CATransform3DIdentity;
            card.layer.opacity = 1;
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.members count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    NSString *aboutText = _members[indexPath.row][@"title"];
    NSString *newlineString = @"\n";
    NSString *newAboutText = [aboutText stringByReplacingOccurrencesOfString:@"\\n" withString:newlineString];
    
    
    CGSize aboutSize = [newAboutText sizeWithFont:font constrainedToSize:CGSizeMake(268, 4000)];
    
    
    
    return (280-15+aboutSize.height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Card";
    CTCardCell *cell = (CTCardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell setupWithDictionary:[self.members objectAtIndex:indexPath.row]];
    cell.tag = indexPath.row;
    [cell setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    cell.profilePhoto.tag =indexPath.row;
    [tapGesture setCancelsTouchesInView:NO];
    [cell.profilePhoto setUserInteractionEnabled:YES];
    [cell.profilePhoto addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *commentGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleComments:)];
    commentGesture.numberOfTapsRequired = 1;
    cell.lblComment.tag =indexPath.row;
    [commentGesture setCancelsTouchesInView:NO];
    [cell.lblComment setUserInteractionEnabled:YES];
    [cell.lblComment addGestureRecognizer:commentGesture];
    
    return cell;
}

-(void)handleTapGesture :(id)sender{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSDictionary *adict = [self.members objectAtIndex:gesture.view.tag];
    NSString *url =[adict valueForKey:@"url_o"];
    self.photos = [NSMutableArray array];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:url]]];
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // browser.wantsFullScreenLayout = YES;
    //  [self.navigationController pushViewController:browser animated:YES];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:nc animated:FALSE completion:NULL];
    
    
    
}

-(void)handleComments: (id)sender{
    
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSDictionary *adict = [self.members objectAtIndex:gesture.view.tag];
    NaviController *tt =[self.storyboard instantiateViewControllerWithIdentifier:@"navigation"];
    tesTtViewController *ttt = tt.viewControllers[0];
    ttt.photoId =[adict valueForKey:@"id"];
    
    [self.tabBarController presentViewController:tt animated:TRUE completion:nil];
    
   
}


- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
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
