//
//  BNRItem.h
//  Homepwner
//
//  Created by Mark on 16/1/19.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSManagedObject


@property (nullable, nonatomic, strong) NSString *itemName;
@property (nullable, nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nullable, nonatomic, strong) NSDate *dateCreated;
@property (nullable, nonatomic, strong) NSString *itemKey;
@property (nullable, nonatomic, strong) UIImage *thumbnail;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, strong) NSManagedObject *assetType;


// Insert code here to declare functionality of your managed object subclass

- (void)setThumbnailFromImage:(UIImage *)image;

+ (instancetype)randomItem;

@end

NS_ASSUME_NONNULL_END

#import "BNRItem+CoreDataProperties.h"
