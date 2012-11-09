//
//  PARDetailViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARVideo.h"
#import "PARVideo.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PARDetailViewController : UIViewController {
    MPMoviePlayerController *moviePlayer;
}

@property (strong, nonatomic) PARVideo *video;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UITextView *videoDescription;
@property (weak, nonatomic) IBOutlet UIImageView *playButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (id)initWithVideo: (PARVideo *)videoInfo;

@end
