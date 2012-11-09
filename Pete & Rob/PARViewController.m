//
//  PARViewController.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARViewController.h"
#import "PARAppDelegate.h"
#import "PARVideo.h"
#import "PARDetailViewController.h"
#import "PARXMLParserDelegate.h"

@interface PARViewController ()

@end

@implementation PARViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    loading = NO;
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Videos";
    loadingStart = 0;
    didLoadCompleteList = NO;
    videos = [[NSMutableArray alloc] init];
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
        NSString *urlString = [NSString stringWithFormat:@"%@%d", @"http://www.peteandrob.com/rss/videos.php?start=", loadingStart];
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        parserDelegate = [[PARXMLParserDelegate alloc] init];
        [parserDelegate addParsingObserver:self];
        [parserDelegate parse:data];
    });
}

- (void)parsingFinished:(NSNotification *)parsedVideos
{
    // Wenn nicht gerade geladen wird, ignorieren, was hier ankommt
    if (!loading) {
        return;
    }
    [videos addObjectsFromArray:[parsedVideos object]];
    loadingStart = parserDelegate.offset;
    didLoadCompleteList = (parserDelegate.total <= loadingStart);
    [self.tableView reloadData];
    [self.spinner stopAnimating];
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
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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

@end
