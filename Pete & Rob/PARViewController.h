//
//  PARViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    int loadingStart;
    NSMutableArray *videos;
    BOOL loading;
    BOOL didLoadCompleteList;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UITableViewCell *loadingCell;

-(void)load;

@end
