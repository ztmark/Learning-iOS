//
//  MKZItemCell.h
//  Homepwner
//
//  Created by Mark on 16/1/17.
//  Copyright © 2016年 Mark. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MKZItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end
