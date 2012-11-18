//
//  PARDetailViewController.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARVideoDetailViewController.h"
#import "PARVideo.h"
#import "PARAppDelegate.h"

@interface PARVideoDetailViewController ()

@end

@implementation PARVideoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:NOTIFICATION_REACHABILITY_CHANGED
                                               object:nil];
    _videoImageView.layer.masksToBounds = YES;
    _videoImageView.layer.cornerRadius = 5;
    _videoImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _videoImageView.layer.borderWidth = 1.5;

    [_playButton setImage:UIImage(@"play.png") forState:UIControlStateNormal];
    [_playButton setImage:UIImage(@"play-highlighted.png") forState:UIControlStateHighlighted];
    [_playButton setHidden:YES];

}

- (void)updateUIForReachability:(BOOL)isOnline
{
    if(isOnline){
        [_playButton setEnabled:YES];
        _playButton.alpha = 1;
    } else {
        [_playButton setEnabled:NO];
        _playButton.alpha = 0.5;
        [_activiyIndicator setHidden:YES];
        [_activiyIndicator stopAnimating];
    }
}

- (void)reachabilityChanged:(NSNotification*)notification
{
    BOOL isOnline = [[notification userInfo][KEY_REACHABILITY] boolValue];
    [self updateUIForReachability:isOnline];
}

- (void)viewWillAppear:(BOOL)animated
{
    _titleLabel.text = _video.title;
    _videoDetailTextView.text = _video.detail;
    
    if(![PARAppDelegate isOnline]){
        [self updateUIForReachability:NO];
        return;
    }
    
    __weak PARVideoDetailViewController* weakSelf = self;
    BasicBlock enableVideoPlayer = ^{
        weakSelf.videoImageView.image = [_video image];
        [weakSelf.activiyIndicator stopAnimating];
        [weakSelf.playButton setHidden:NO];
        [weakSelf.videoImageView setNeedsDisplay];
    };
    
    if (!self.video.image) {
        
        [_activiyIndicator startAnimating];
        _videoImageView.image = [UIImage imageNamed:@"pete-and-rob-logo.png"];
        [_video onImageLoaded:^(UIImage *image) {
            enableVideoPlayer();
        }];

    } else {
         enableVideoPlayer();
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)playButtonTouched:(id)sender
{
    NSURL *url = [NSURL URLWithString:_video.url];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    moviePlayer.view.frame = self.videoImageView.frame;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];

}

- (IBAction)shareButtonTouched:(id)sender
{
    id items = @[_video.title, _video.image, _video.url];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    avc.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard];
    [self presentViewController:avc animated:YES completion:nil];
}


- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        moviePlayer.view.alpha = 0;
    } completion:^(BOOL finished) {
        [moviePlayer.view removeFromSuperview];
    }];
}

@end
