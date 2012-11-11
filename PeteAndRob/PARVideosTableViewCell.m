//
//  PARVideosTableViewCell.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARVideosTableViewCell.h"
#import "PARVideo.h"

@implementation PARVideosTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.imageView.layer.borderWidth = 1.5;
    
    self.textLabel.font = FONT_DEFAULT(FONTSIZE_DEFAULT);
    self.textLabel.numberOfLines = 2;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake( 5, 5, 73, 55 ); // your positioning here
}

- (void)setVideo:(PARVideo*)video
{
    self.textLabel.text = video.title;
    self.imageView.image = video.image;
    
    if (!self.imageView.image) {
        self.imageView.image = [UIImage imageNamed:@"pete-and-rob-logo.png"];
        __weak PARVideosTableViewCell *weakSelf = self;
        [video onImageLoaded:^(UIImage *image) {
            // cell can be dequeued
            if(![weakSelf.textLabel.text isEqualToString:video.title]){
                return;
            }
            if([self isLowPerformanceDevice]){
                weakSelf.imageView.image = video.image;
                return;
            }
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.imageView.alpha = 0;
            } completion:^(BOOL finished) {
                weakSelf.imageView.image = video.image;
                 [UIView animateWithDuration:0.3 animations:^{
                     weakSelf.imageView.alpha = 1;
                 }];
            }];
        }];
    }
}

@end
