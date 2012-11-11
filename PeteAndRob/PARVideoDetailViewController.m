//
//  PARDetailViewController.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARVideoDetailViewController.h"
#import "PARVideo.h"

@interface PARVideoDetailViewController ()

@end

@implementation PARVideoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(imageTapped:)];
    self.playButtonImageView.userInteractionEnabled = YES;
    [self.playButtonImageView addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:moviePlayer];
    
    self.videoImageView.layer.masksToBounds = YES;
    self.videoImageView.layer.cornerRadius = 5;
    self.videoImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.videoImageView.layer.borderWidth = 1.5;

    self.playButtonImageView.layer.shadowOpacity = 1;
    self.playButtonImageView.layer.shadowRadius = 6;
    self.playButtonImageView.layer.shadowOffset = CGSizeZero;
    self.playButtonImageView.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.videoDetailTextView.text = _video.detail;
    
    __weak PARVideoDetailViewController* weakSelf = self;
    BasicBlock enableVideoPlayer = ^{
        weakSelf.videoImageView.image = [_video image];
        [weakSelf.activiyIndicator stopAnimating];
        [weakSelf.playButtonImageView setHidden:NO];
        [weakSelf.videoImageView setNeedsDisplay];
    };
    
    if (!self.video.image) {
        
        [self.activiyIndicator startAnimating];
        self.videoImageView.image = [UIImage imageNamed:@"pete-and-rob-logo.png"];
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
    // Dispose of any resources that can be recreated.
}

- (void)imageTapped:(UITapGestureRecognizer *) gestureRecognizer
{
    [self.playButtonImageView setHighlighted:YES];

    NSURL *url = [NSURL URLWithString:_video.url];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    moviePlayer.view.frame = self.videoImageView.frame;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        moviePlayer.view.alpha = 0;
    } completion:^(BOOL finished) {
        [moviePlayer.view removeFromSuperview];
        [self.playButtonImageView setHighlighted:NO];
    }];
}

@end
