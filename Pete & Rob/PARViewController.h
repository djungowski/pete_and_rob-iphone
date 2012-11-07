//
//  PARViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PARViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    MPMoviePlayerController *moviePlayer;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
