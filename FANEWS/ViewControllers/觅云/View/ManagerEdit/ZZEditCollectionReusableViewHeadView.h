//
//  ZZEditCollectionReusableViewHeadView.h
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZEditCollectionReusableViewHeadView : UICollectionReusableView

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
