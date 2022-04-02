//
//  ZZHotSearchCell.h
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZHotSearchCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *sortingLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIImageView *tagImage;

- (void)setCellWith:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
