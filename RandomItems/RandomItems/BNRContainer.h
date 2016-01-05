//
// Created by Mark on 15/12/15.
// Copyright (c) 2015 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"


@interface BNRContainer : BNRItem

@property (nonatomic, copy) NSMutableArray *_subItems;

- (instancetype)initWithItemsCount:(NSUInteger) count;

@end