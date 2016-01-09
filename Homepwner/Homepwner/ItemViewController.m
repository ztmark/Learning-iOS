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

@interface ItemViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; ++i) {
            [[ItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

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


- (IBAction)addNewItem:(id)sender {

}

- (IBAction)toggleEditingMode:(id)sender {

}

- (UIView *)headerView {
    if (_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

@end
