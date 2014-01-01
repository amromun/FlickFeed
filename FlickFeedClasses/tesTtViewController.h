//
//  tesTtViewController.h
//  FlickFeed
//
//  Created by Amro Munajjed on 12/31/13.

//

#import <UIKit/UIKit.h>
#import "YIPopupTextView.h"

@interface tesTtViewController : UITableViewController <YIPopupTextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (strong , nonatomic) NSString *photoId;
@property (weak, nonatomic) IBOutlet UILabel *commlbl;
@property (nonatomic,strong) NSDictionary *commentDict;
@property (weak, nonatomic) IBOutlet UILabel *authlbl;
@property (nonatomic,strong) NSArray *commentArr;
@end
