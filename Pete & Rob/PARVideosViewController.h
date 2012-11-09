//
//  PARVideosViewController.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARXMLParserDelegate.h"

@interface PARVideosViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    int loadingStart;
    NSMutableArray *videos;
    BOOL loading;
    BOOL didLoadCompleteList;
    PARXMLParserDelegate *parserDelegate;
}
@property (strong, nonatomic) IBOutlet UITableViewCell *loadingCell;

-(void)load;


@end
