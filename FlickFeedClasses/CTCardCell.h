//
//  CTCardCell.h
//  
//
//  Created by Brian Broom on 8/16/13.
//  
//

#import <UIKit/UIKit.h>

@interface CTCardCell : UITableViewCell 

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;
@property (weak, nonatomic) IBOutlet UIButton *webButton;
@property (weak, nonatomic) IBOutlet UIImageView *twImage;
@property (weak, nonatomic) IBOutlet UIButton *twButton;
@property (weak, nonatomic) IBOutlet UIImageView *fbImage;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (nonatomic,strong) NSDictionary *DictCopy;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

- (void)setupWithDictionary:(NSDictionary *)dictionary;

@end
