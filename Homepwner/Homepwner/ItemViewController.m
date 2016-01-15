//
//  ItemViewController.m
//  Homepwner
//
//  Created by Mark on 16/1/9.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "ItemViewController.h"
#import "BNRItem.h"
#import "ItemStore.h"
#import "DetailViewController.h"

@interface ItemViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemViewController

#pragma mark - View Life cycle

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigationItem.title = @"Homepwner";

        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        self.navigationItem.rightBarButtonItem = bbi;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Actions

- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[ItemStore sharedStore] createItem];
//    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:YES];
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navigationController animated:YES completion:nil];

}


#pragma mark - Table View data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = item.description;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:NO];

    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    detailViewController.item = selectedItem;

    [self.navigationController pushViewController:detailViewController animated:YES];
}







@end
