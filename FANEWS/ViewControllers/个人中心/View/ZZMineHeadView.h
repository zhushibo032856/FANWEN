//
//  ZZMineHeadView.h
//  FANEWS
//
//  Created by fanews on 2022/3/16.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^infoDetailBlock)(void);
@interface ZZMineHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *vipBt;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, copy) infoDetailBlock block;
+ (instancetype)initMineHeadView;

- (void)initViewWith;

@end

NS_ASSUME_NONNULL_END
