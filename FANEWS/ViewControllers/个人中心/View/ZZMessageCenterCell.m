//
//  ZZMessageCenterCell.m
//  FANEWS
//
//  Created by fanews on 2022/3/17.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZMessageCenterCell.h"

@implementation ZZMessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.judeLabel.layer.masksToBounds = YES;
    self.judeLabel.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
