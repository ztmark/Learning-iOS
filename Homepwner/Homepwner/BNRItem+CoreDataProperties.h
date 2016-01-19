//
//  BNRItem+CoreDataProperties.h
//  Homepwner
//
//  Created by Mark on 16/1/19.
//  Copyright © 2016年 Mark. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import <UIKit/UIKit.h>

#import "BNRItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem (CoreDataProperties)

@property (nullable, nonatomic, strong) NSString *itemName;
@property (nullable, nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nullable, nonatomic, strong) NSDate *dateCreated;
@property (nullable, nonatomic, strong) NSString *itemKey;
@property (nullable, nonatomic, strong) UIImage *thumbnail;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, strong) NSManagedObject *assetType;

@end

NS_ASSUME_NONNULL_END
