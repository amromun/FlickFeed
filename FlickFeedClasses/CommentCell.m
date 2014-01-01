//
//  CommentCell.m
//  FlickFeed
//
//  Created by Amro Munajjed on 12/31/13.
//
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize autho,comment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
