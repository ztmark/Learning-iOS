//
//  main.m
//  RandomItems
//
//  Created by Mark on 15/12/15.
//  Copyright © 2015年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
#import "BNRContainer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        /*[items addObject:@"one"];
        [items addObject:@"tow"];
        [items addObject:@"three"];
        [items addObject:@"four"];
        [items insertObject:@"zero" atIndex:0];
        
        for (int i=0; i < [items count]; i++) {
//            NSLog(@"%@", [items objectAtIndex:i]);
            NSLog(@"%@", items[i]);

        }
        NSLog(@"=========");
        for (NSString* item in items) {
            NSLog(@"%@", item);
        }
        
        BNRItem *item = [[BNRItem alloc] init];
//        [item setValueInDollars:20];
//        [item setSerialNumber:@"djfe"];
//        [item setItemName:@"mark"];
//        NSLog(@"%@ %@ %@ %d", [item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);
        item.valueInDollars = 20;
        item.serialNumber = @"djfe";
        item.itemName = @"mark";
//        NSLog(@"%@ %@ %@ %d", item.itemName, item.dateCreated, item.serialNumber, item.valueInDollars);
        
        NSLog(@"%@", item);
        
        BNRItem *item1 = [[BNRItem alloc] initWithItemName:@"Mark"];
        NSLog(@"%@", item1);
        
        BNRItem *item2 = [[BNRItem alloc] initWithItemName:@"Jack" valueInDollars:88 serialNumber:@"abcd"];
        NSLog(@"%@", item2);
        
        BNRItem *item3 = [[BNRItem alloc] init];
        NSLog(@"%@", item3);*/

        /*for (int i = 0; i < 10; ++i) {
            [items addObject:[BNRItem randomItem]];
        }
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }

        BNRItem *item1 = [[BNRItem alloc] intiWithItemName:@"mark" serialNumber:@"12345"];
        NSLog(@"%@", item1);*/


        BNRContainer *container = [[BNRContainer alloc] initWithItemsCount:3];
        NSLog(@"%@", container);


        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];

        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];

        backpack.containedItem = calculator;

        backpack = nil;
        calculator = nil;

        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }

        NSLog(@"Setting items to nil...");
        items = nil;

        NSLog(@"After set items to nil");
        NSLog(@"wating....");

    }
    return 0;
}
