//
//  ZZEditInfoCell.h
//  FANEWS
//
//  Created by fanews on 2022/4/6.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZEditInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UITextField *infoTF;
@property (nonatomic, strong) UIImageView *nextImageView;

- (void)initCellWith;

@end

NS_ASSUME_NONNULL_END
