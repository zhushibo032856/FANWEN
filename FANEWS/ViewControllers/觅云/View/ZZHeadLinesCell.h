//
//  ZZHeadLinesCell.h
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZHeadLinesCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *newsImageView;

- (void)initCellWith;

@end

NS_ASSUME_NONNULL_END
