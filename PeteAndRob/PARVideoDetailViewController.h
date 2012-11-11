//
//  PARDetailViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARVideo.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PARVideoDetailViewController : UIViewController {
    MPMoviePlayerController *moviePlayer;
}

@property (strong, nonatomic) PARVideo *video;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UITextView *videoDetailTextView;
@property (weak, nonatomic) IBOutlet UIImageView *playButtonImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiyIndicator;

@end