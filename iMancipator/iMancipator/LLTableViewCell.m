//
//  LLTableViewCell.m
//  iMancipator
//
//  Created by Mason on 11/29/12.
//  Copyright (c) 2012 A-Team. All rights reserved.
//

#import "LLTableViewCell.h"

@implementation LLTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected && self.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.selected = NO;
        self.accessoryType = UITableViewCellAccessoryNone;
        
    } else {
        self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

@end
