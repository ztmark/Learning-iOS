//
//  ItemStore.h
//  Homepwner
//
//  Created by Mark on 16/1/9.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;

@end
