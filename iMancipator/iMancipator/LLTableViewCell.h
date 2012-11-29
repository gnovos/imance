//
//  LLTableViewCell.h
//  iMancipator
//
//  Created by Mason on 11/29/12.
//  Copyright (c) 2012 A-Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (weak, nonatomic) IBOutlet UILabel *distance;


@end
