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


@end
