//
//  BNRItem.h
//  RandomItems
//
//  Created by Mark on 15/12/15.
//  Copyright © 2015年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, strong) BNRItem *containedItem;
@property (nonatomic, weak) BNRItem *contianer;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name;
- (instancetype)intiWithItemName:(NSString *)name serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;


@end
