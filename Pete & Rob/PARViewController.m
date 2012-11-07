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
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Videos";
//    [self.spinner startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL* url = [NSURL URLWithString:@"http://www.peteandrob.com/rss/podcast.php"];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        PARXMLParserDelegate *parserDelegate = [[PARXMLParserDelegate alloc] init];
        [parser setDelegate:parserDelegate];
        [parser parse];
        
        videos = parserDelegate.videos;
        [self.spinner stopAnimating];
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PARAppDelegate *delegate = (PARAppDelegate *)[[UIApplication sharedApplication] delegate];
    return [videos count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PARVideo *video = [videos objectAtIndex:indexPath.row];
    
    PARDetailViewController *controller = [[PARDetailViewController alloc] initWithVideo:video];
    
    PARAppDelegate *delegate = (PARAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.navController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PARVideo *video = [videos objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = video.title;
    cell.imageView.image = video.image;
    return cell;
}

@end
