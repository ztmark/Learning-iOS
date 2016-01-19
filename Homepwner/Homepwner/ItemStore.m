//
//  ItemStore.m
//  Homepwner
//
//  Created by Mark on 16/1/9.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"
#import "ImageStore.h"
@import CoreData;

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end


@implementation ItemStore

+ (instancetype)sharedStore {
    static ItemStore *sharedStore = nil;
//    if (!sharedStore) {
//        sharedStore = [[ItemStore alloc] initPrivate];
//    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ItemStore sharedStore]" userInfo:nil];
    return nil;
}


- (instancetype)initPrivate {
    self = [super init];
    if (self) {
//        self.privateItems = [[NSMutableArray alloc] init];
//        NSString *path = [self itemArchivePath];
//        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        if (!_privateItems) {
//            _privateItems = [[NSMutableArray alloc] init];
//        }
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = psc;
        [self loadAllItems];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}


- (BNRItem *)createItem {

    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item {
    [[ImageStore sharedStore] deleteImageForKey:item.itemKey];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectIdenticalTo:item];
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (BOOL)saveChanges {
//    NSString *path = [self itemArchivePath];
//    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    
    }
    return successful;
}


- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
//    return [documentDirectory stringByAppendingPathComponent:@"item.archive"];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}


- (void)loadAllItems {
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRItem" inManagedObjectContext:self.context];
        request.entity = e;
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}


@end
