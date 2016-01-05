//
// Created by Mark on 15/12/15.
// Copyright (c) 2015 Mark. All rights reserved.
//

#import "BNRContainer.h"


@implementation BNRContainer

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"%@: ", super.itemName];
    int sum = super.valueInDollars;
    for (BNRItem *item in __subItems) {
        sum += item.valueInDollars;
    }
    [description appendFormat:@" total value is %d", sum];
    return description;
}


- (instancetype)initWithItemsCount:(NSUInteger)count {
    self = [super initWithItemName:@"container" valueInDollars:22 serialNumber:@"12334"];
    if (self) {
        __subItems = [[NSMutableArray alloc] initWithCapacity:count];
        for (NSUInteger i = 0; i < count; ++i) {
            __subItems[i] = [BNRItem randomItem];
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithItemsCount:0];
}



@end