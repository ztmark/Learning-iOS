//
//  MKZItemCell.m
//  Homepwner
//
//  Created by Mark on 16/1/17.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MKZItemCell.h"

@implementation MKZItemCell


- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}


@end
