//
//  MKZImageTransformer.m
//  Homepwner
//
//  Created by Mark on 16/1/19.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKZImageTransformer.h"

@implementation MKZImageTransformer

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
    return [UIImage imageWithData:value];
}

@end
