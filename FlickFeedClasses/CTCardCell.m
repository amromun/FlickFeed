//
//  CTCardCell.m
//  
//
// //
//

#import "CTCardCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@interface CTCardCell () {
    NSString *website;
    NSString *twitter;
    NSString *facebook;
}

@end

@implementation CTCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
 
    }
    return self;
}



- (void)setupWithDictionary:(NSDictionary *)dictionary
{
    self.mainView.layer.cornerRadius = 10;
    self.mainView.layer.masksToBounds = YES;
    
    NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [dictionary valueForKey:@"farm"], [dictionary valueForKey:@"server"], [dictionary valueForKey:@"id"], [dictionary valueForKey:@"secret"]];
    NSURL * imageURL = [NSURL URLWithString:photoURLString];
   // NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
   // UIImage * image = [UIImage imageWithData:imageData];
    
  
    [self.profilePhoto setImageWithURL:imageURL];
   /// self.profilePhoto.image =image;
    self.profilePhoto.contentMode = UIViewContentModeScaleToFill;
    self.profilePhoto.backgroundColor = [UIColor clearColor];
    self.nameLabel.text = [dictionary valueForKey:@"ownername"];
    self.titleLabel.text = [dictionary valueForKey:@"title"];
   // self.locationLabel.text = [dictionary valueForKey:@"location"];
    self.locationLabel.text = [NSString stringWithFormat:@"Date Taken : %@", [dictionary valueForKey:@"datetaken"]];
    NSDictionary *dd =  [dictionary valueForKey:@"description"];
    NSString *aboutText = [dd valueForKey:@"_content"];
    NSString *newlineString = @"\n";        
    self.aboutLabel.text = [aboutText stringByReplacingOccurrencesOfString:@"\\n" withString:newlineString];
    
    website = [dictionary valueForKey:@"web"];
    if (website) {
        self.webLabel.text = [dictionary valueForKey:@"web"];
    } else {
        self.webLabel.hidden = YES;
        self.webButton.hidden = YES;
    }
    
    twitter = [dictionary valueForKey:@"twitter"];
    if (!twitter) {
        self.twImage.hidden = YES;
        self.twButton.hidden = YES;
    } else {
        self.twImage.hidden = NO;
        self.twButton.hidden = NO;
    }
    
    facebook = [dictionary valueForKey:@"facebook"];
    if (!facebook) {
        self.fbImage.hidden = YES;
        self.fbButton.hidden = YES;
    } else {
        self.fbImage.hidden = NO;
        self.fbButton.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)launchWeb:(id)sender
{
    if (website) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
    }
}

- (IBAction)launchTwitter:(id)sender
{
    if (twitter) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitter]];
    }
}


- (IBAction)launchFacebook:(id)sender
{
    if (facebook) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:facebook]];
    }
}

@end
