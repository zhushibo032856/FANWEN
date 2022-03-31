//
//  ZZThematicNormalCell.h
//  FANEWS
//
//  Created by fanews on 2022/3/24.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTextModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZZThematicNormalCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) UILabel *lineLabel;

- (void)initCellWith:(ZZTextModel *)model;

@end

NS_ASSUME_NONNULL_END
