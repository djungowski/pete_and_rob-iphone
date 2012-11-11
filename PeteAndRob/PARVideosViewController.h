//
//  PARVideosViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARVideosViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* videos;

@end
