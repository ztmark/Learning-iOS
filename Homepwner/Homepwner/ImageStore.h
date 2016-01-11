//
//  ImageStore.h
//  Homepwner
//
//  Created by Mark on 16/1/11.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStore : NSObject


+ (instancetype)sharedStore;

- (id)initPrivate;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;


@end
