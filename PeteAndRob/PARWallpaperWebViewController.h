//
//  PARWallpaperWebViewController.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 12.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARWallpaperWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *url;

@end
