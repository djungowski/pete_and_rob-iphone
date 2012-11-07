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

@interface PARViewController ()

@end

@implementation PARViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Stopmotion";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PARAppDelegate *delegate = (PARAppDelegate *)[[UIApplication sharedApplication] delegate];
    return [delegate.videos count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PARAppDelegate *delegate = (PARAppDelegate *)[[UIApplication sharedApplication] delegate];
    PARVideo *video = [delegate.videos objectAtIndex:indexPath.row];
    
    PARDetailViewController *controller = [[PARDetailViewController alloc] initWithVideo:video];
    [delegate.navController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PARAppDelegate *delegate = (PARAppDelegate *)[[UIApplication sharedApplication] delegate];
    PARVideo *video = [delegate.videos objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = video.title;
    cell.imageView.image = video.image;
    return cell;
}

@end
