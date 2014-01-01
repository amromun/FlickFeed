//
//  UploadViewController.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/28/13.
//
//

#import "UploadViewController.h"
#import "FlickrKit.h"

@interface UploadViewController ()
@property (nonatomic, retain) FKImageUploadNetworkOperation *uploadOp;
@end

@implementation UploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    
}

-(void)clear{
    [self.previewImage setImage:[UIImage imageNamed:@"Upload_big.png"]];
    self.desTxt.text = @"";
    self.nameTxt.text  = @"";
    [self.isPublic setOn:NO];
    [self.isFamily setOn:NO];
   [self.isFriend setOn:NO];
    self.progress.progress = 0.0;
}

- (IBAction)takePhotoUsingCamera:(id)sender {
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
        //    [imagePicker.delegate self];
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentViewController:imagePicker animated:YES completion:nil];
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please login first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}

}

- (IBAction)pickPhoto:(id)sender {
    
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
    //    [imagePicker.delegate self];
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentViewController:imagePicker animated:YES completion:nil];
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please login first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}

}
- (IBAction)uploadPhoto:(id)sender {
    if (self.selectedPhoto != NULL) {
        
    
    bool isPublic = [self.isPublic isOn];
    bool isFamily = [self.isFamily isOn];
    bool isFriend = [self.isFriend isOn];
    
    NSString * isPublicString = (isPublic) ? @"1" : @"0";
    NSString * isFamilyString = (isFamily) ? @"1" : @"0";
    NSString * isFriendString = (isFriend) ? @"1" : @"0";
    
    NSDictionary *uploadArgs = @{@"title": self.nameTxt.text, @"description": self.desTxt.text, @"is_public": isPublicString, @"is_friend": isFriendString, @"is_family": isFamilyString, @"hidden": @"2"};
    
    self.progress.progress = 0.0;
	self.uploadOp =  [[FlickrKit sharedFlickrKit] uploadImage:self.selectedPhoto args:uploadArgs completion:^(NSString *imageID, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (error) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
			} else {
				NSString *msg = [NSString stringWithFormat:@"Uploaded image ID %@", imageID];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
			}
            [self.uploadOp removeObserver:self forKeyPath:@"uploadProgress" context:NULL];
            [self clear];
        });
	}];
    [self.uploadOp addObserver:self forKeyPath:@"uploadProgress" options:NSKeyValueObservingOptionNew context:NULL];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please a photo to upload" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
    }

}


-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
       
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
      
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (IBAction)textFieldFinished:(id)sender
{
     [sender resignFirstResponder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - Progress KVO

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        self.progress.progress = progress;
        //[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    });
}


#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *imagePicked = [info objectForKey:UIImagePickerControllerOriginalImage];
	self.selectedPhoto = imagePicked;
    self.previewImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.previewImage setImage:imagePicked];
   	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
