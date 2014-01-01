//
//  UploadViewController.h
//  FlickFeed
//
//  Created by Amro Munajjed on 12/28/13.
//  
//

#import <UIKit/UIKit.h>

@interface UploadViewController : UIViewController <UITextFieldDelegate , UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *desTxt;
@property (strong,nonatomic) UIImage *selectedPhoto;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (weak, nonatomic) IBOutlet UISwitch *isPublic;
@property (weak, nonatomic) IBOutlet UISwitch *isFamily;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoCamera;

@property (weak, nonatomic) IBOutlet UISwitch *isFriend;
@end
