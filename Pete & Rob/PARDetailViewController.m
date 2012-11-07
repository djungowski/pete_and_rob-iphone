//
//  PARDetailViewController.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARDetailViewController.h"

@interface PARDetailViewController ()

@end

@implementation PARDetailViewController

@synthesize video;

- (id)initWithVideo:(PARVideo *)videoInfo
{
    self = [super init];
    if (self) {
        self.video = videoInfo;
        self.title = videoInfo.title;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.videoImage.image = video.image;
    self.videoDescription.text = video.description;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self              action:@selector(imageTapped:)];
    self.playButton.userInteractionEnabled = YES;
    [self.playButton addGestureRecognizer:tap];
}

- (void )imageTapped:(UITapGestureRecognizer *) gestureRecognizer
{
    [self.playButton setHighlighted:YES];

    NSURL *url = [NSURL URLWithString:video.url];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
