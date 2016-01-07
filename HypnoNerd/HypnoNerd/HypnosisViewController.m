//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by Mark on 16/1/7.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "HypnosisView.h"
#import "HypnosisViewController.h"


@implementation HypnosisViewController


- (void)loadView {
    HypnosisView *backgroundView = [[HypnosisView alloc] init];
    self.view = backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HypnosisViewController loaded its view");
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = i;
    }

    return self;
}


@end
