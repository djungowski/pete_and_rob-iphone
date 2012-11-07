//
//  PARViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
