//
//  MKZWebViewController.m
//  Nerdfeed
//
//  Created by Mark on 16/1/18.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MKZWebViewController.h"

@interface MKZWebViewController ()

@end

@implementation MKZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)setURL:(NSURL *)URL {
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}


//- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
//    if (barButtonItem == self.navigationItem.leftBarButtonItem) {
//        self.navigationItem.leftBarButtonItem = nil;
//    }
//}

- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    if (displayMode == UISplitViewControllerDisplayModePrimaryOverlay) {
        self.navigationItem.leftBarButtonItem = nil;
    } else if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        svc.displayModeButtonItem.title = @"Courses";
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
