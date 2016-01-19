//
//  BNRItem.m
//  Homepwner
//
//  Created by Mark on 16/1/19.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem



// Insert code here to add functionality to your managed object subclass



- (void)setThumbnailFromImage:(UIImage *)image {
    CGSize origImageSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    UIGraphicsEndImageContext();
}

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.itemKey = key;
}


+ (instancetype)randomItem
{
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0'+arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}


- (void)dealloc {
    NSLog(@"Destroyed: %@", self);
}


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.itemName forKey:@"itemName"];
    [coder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [coder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [coder encodeObject:self.itemKey forKey:@"itemKey"];
    [coder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [coder encodeObject:self.thumbnail forKey:@"thumbnail"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.itemName = [coder decodeObjectForKey:@"itemName"];
        self.serialNumber = [coder decodeObjectForKey:@"serialNumber"];
        self.dateCreated = [coder decodeObjectForKey:@"dateCreated"];
        self.itemKey = [coder decodeObjectForKey:@"itemKey"];
        self.valueInDollars = [coder decodeIntForKey:@"valueInDollars"];
        self.thumbnail = [coder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    if (self) {
        self.itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        self.dateCreated = [[NSDate alloc] init];
        NSUUID *uuid = [[NSUUID alloc] init];
        self.itemKey = [uuid UUIDString];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)intiWithItemName:(NSString *)name serialNumber:(NSString *)sNumber {
    return [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
}


- (instancetype)init
{
    return [self initWithItemName:@"Item"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@): Worth $%d, recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
}

@end
