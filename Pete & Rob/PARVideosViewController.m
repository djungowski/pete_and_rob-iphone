//
//  PARVideosViewController.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARVideosViewController.h"
#import "PARAppDelegate.h"
#import "PARVideo.h"
#import "PARDetailViewController.h"
#import "PARVideosTableViewCell.h"

@interface PARVideosViewController ()

@end

@implementation PARVideosViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loading = NO;
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Adventures";
    loadingStart = 0;
    didLoadCompleteList = NO;
    videos = [[NSMutableArray alloc] init];
    
    videoData = [[PARDataVideos alloc] init];
    [videoData addParsingObserver:self];
    
    // Pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh..."];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    // Daten laden
    [self load];
}

- (void)load
{
    // Nichts laden, wennn wir bereits am Ende der Liste sind oder wenn gerade geladen wird
    if (didLoadCompleteList || loading) {
        return;
    }
    loading = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Laden..."];
        [self.refreshControl beginRefreshing];
        [videoData load:loadingStart];
    });
}

-(void)refreshView:(UIRefreshControl *)refresh
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Laden..."];
    loading = NO;
    loadingStart = 0;
    didLoadCompleteList = NO;
    videos = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    [self load];
}

- (void)parsingFinished:(NSNotification *)parsedVideos
{
    // Wenn nicht gerade geladen wird, ignorieren, was hier ankommt
    if (!loading) {
        return;
    }
    [videos addObjectsFromArray:[parsedVideos object]];
    loadingStart = videoData.offset;
    didLoadCompleteList = (videoData.total <= loadingStart);
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
    loading = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [videos count];
    if (count > 0 && !didLoadCompleteList) {
        return count + 1;
    } else {
        return count;
    }
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    PARVideo *video = [videos objectAtIndex:indexPath.row];
    
    PARDetailViewController *controller = [[PARDetailViewController alloc] initWithVideo:video];
    
    PARAppDelegate *delegate = (PARAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.navController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int videosCount = [videos count];
    if (videosCount > 0) {
        // If scrolled beyond 80% of the table, load next batch of data.
        if (indexPath.row >= (videosCount * 0.8)) {
            if (!loading) {
                [self load];
            }
        }
        if (indexPath.row < videosCount) {
//            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            PARVideosTableViewCell *cell = [[PARVideosTableViewCell alloc] init];
            PARVideo *video = [videos objectAtIndex:indexPath.row];
            cell.textLabel.text = video.title;
            
            if (!video.image) {
                cell.imageView.image = [UIImage imageNamed:@"pete-and-rob-logo.png"];
                
                // Bilder asynchron nachladen
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    NSURL *imageURL = [NSURL URLWithString:video.imageString];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        UITableViewCell *cell = [tv cellForRowAtIndexPath:indexPath];
                        video.image = [UIImage imageWithData:imageData];
                        cell.imageView.image = video.image;
                        [cell setNeedsLayout];
                    });
                });
            } else {
                cell.imageView.image = video.image;
            }
            return cell;
        } else {
            return self.loadingCell;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

@end
