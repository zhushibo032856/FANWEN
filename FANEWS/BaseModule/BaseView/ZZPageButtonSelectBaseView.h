//
//  ZZPageButtonSelectBaseView.h
//  FANEWS
//
//  Created by fanews on 2022/3/24.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZZPageButtonDelegate <NSObject>
//选中时候的回调
- (void)didSelectedIndex:(NSInteger)index;

@end


@interface ZZPageButtonSelectBaseView : UIView

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray * dataArr;
/**
 *  标签文字颜色_未选中时
 */
@property (nonatomic, strong) UIColor * tagTextColor_normal;
/**
 *  标签文字颜色_选中时
 */
@property (nonatomic, strong) UIColor * tagTextColor_selected;
/**
 *  标签文字颜色_未选中时
 */
@property (nonatomic, assign)CGFloat tagTextFont_normal;
/**
 *  标签文字颜色_选中时
 */
@property (nonatomic, assign)CGFloat tagTextFont_selected;
/**
 *  delegate
 */
@property (nonatomic, assign)id<ZZPageButtonDelegate> delegate;

/**
 *  选择某一个标签
 */
- (void)selectingOneTagWithIndex:(NSInteger )index;
@property (nonatomic, assign) NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
