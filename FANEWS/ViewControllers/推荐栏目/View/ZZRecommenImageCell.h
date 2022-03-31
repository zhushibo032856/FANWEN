//
//  ZZRecommenImageCell.h
//  FANEWS
//
//  Created by fanews on 2022/3/31.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTextModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZZRecommenImageCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *newPhotoImage;
@property (nonatomic, strong) UILabel *lineLabel;

+ (CGFloat)heightWithModel:(ZZTextModel *)model;

- (void)initCellWith:(ZZTextModel *)model;
@end

NS_ASSUME_NONNULL_END
