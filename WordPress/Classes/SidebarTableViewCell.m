//
//  SidebarTableViewCell.m
//  WordPress
//
//  Created by Danilo Ercoli on 05/06/12.
//  Copyright (c) 2012 WordPress. All rights reserved.
//

#import "SidebarTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SidebarTableViewCell (Private)

- (void)receivedCommentsChangedNotification:(NSNotification*)aNotification;

@end;

@implementation SidebarTableViewCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.shadowOffset = CGSizeMake(0, 1.1f);
        self.textLabel.shadowColor = [UIColor blackColor];
        //self.textLabel.textColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
        self.textLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        self.textLabel.font = [UIFont systemFontOfSize:17.0];
        //self.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"sidebar_cell_bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:2]];
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        [self.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:59.0/255.0 blue:145.0/255.0 alpha:1.0]];
        
        CALayer* border = [CALayer layer];
        border.borderColor = [UIColor colorWithRed:101.0f/255.0f green:97.0f/255.0f blue:97.0f/255.0f alpha:1].CGColor;
        border.borderWidth = 1;
        CGFloat w = self.frame.size.width - (IS_IPAD ? 26.0 : 75.0);
        //border.frame = CGRectMake(12, self.layer.frame.size.height-2, w, 1);
        border.frame = CGRectMake(12, self.layer.frame.size.height+3, w, 1);
        [self.layer addSublayer:border];
    }
    return self;
}

- (Blog *)blog {
    return blog;
}

- (void)setBlog:(Blog *)value {
    blog = value;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if ( blog ) { 
        //do other stuff here
        int numberOfPendingComments = [blog numberOfPendingComments];
        if( numberOfPendingComments > 0 ) {
            UIImage *img = [UIImage imageNamed:@"sidebar_comment_bubble"];
            UIImageView *image = [[UIImageView alloc] initWithImage:img];
            UILabel *commentsLbl = [self commentsBadgeLabel:image.bounds text:(numberOfPendingComments > 99) ? NSLocalizedString(@"99⁺", "") : [NSString stringWithFormat:@"%d", numberOfPendingComments]];
            [image addSubview:commentsLbl];
            self.accessoryView = image;
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receivedCommentsChangedNotification:) 
                                                         name:kCommentsChangedNotificationName
                                                       object:blog];
        }
    }
}

- (void)prepareForReuse{
	[super prepareForReuse];
    self.blog = nil;
    self.accessoryView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)receivedCommentsChangedNotification:(NSNotification*)aNotification {
    if ( blog ) { 
        //do other stuff here
        int numberOfPendingComments = [blog numberOfPendingComments];
        if( numberOfPendingComments > 0 ) {
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebar_comment_bubble"]];
            UILabel *commentsLbl = [self commentsBadgeLabel:image.bounds text:(numberOfPendingComments > 99) ? NSLocalizedString(@"99⁺", "") : [NSString stringWithFormat:@"%d", numberOfPendingComments]];
            [image addSubview:commentsLbl];
            self.accessoryView = image;
        } else {
            self.accessoryView = nil;
        }
    }
}

- (UILabel *)commentsBadgeLabel:(CGRect)aRect text:(NSString *) text {
    aRect.origin.y = -1.0f;
    UILabel *commentsLbl = [[UILabel alloc]initWithFrame:aRect];
    commentsLbl.backgroundColor = [UIColor clearColor];
    commentsLbl.textAlignment = UITextAlignmentCenter;
    commentsLbl.text = text;
    commentsLbl.font = [UIFont systemFontOfSize:17.0];
    commentsLbl.textColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    commentsLbl.shadowOffset = CGSizeMake(0, 1.1f);
    commentsLbl.shadowColor = [UIColor blackColor];
    return commentsLbl;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (self.accessoryView && [self.accessoryView isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self.accessoryView;
        [btn setHighlighted:NO];
    }
}

@end
