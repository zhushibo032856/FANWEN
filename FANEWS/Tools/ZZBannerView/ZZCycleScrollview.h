//
//  ZZCycleScrollview.h
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZZCycleScrollViewPageContolAlimentLeft,
    ZZCycleScrollViewPageContolAlimentRight,
    ZZCycleScrollViewPageContolAlimentCenter,
    
} ZZCycleScrollViewPageContolAliment;

typedef enum {
    ZZCycleScrollViewPageContolStyleClassic,        // 系统自带经典样式
    ZZCycleScrollViewPageContolStyleAnimated,       // 不规则图片样式
    ZZCycleScrollViewPageContolStyleNone            // 不显示pagecontrol
} ZZCycleScrollViewPageContolStyle;

typedef enum{
    ZZPageControlMaginTypeCircleType = 1,  // 圆形
    ZZPageControlMaginTypeOvalType //半圆形
}ZZPageControlMaginType;

@class ZZCycleScrollview;

@protocol ZZCycleScrollViewDegelate <NSObject>

@optional
/** 点击图片回调 */
- (void)zz_cycleScrollView:(ZZCycleScrollview *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)zz_cycleScrollView:(ZZCycleScrollview *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end

@interface ZZCycleScrollview : UIView

/* 初始轮播图 */
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<ZZCycleScrollViewDegelate>)delegate placeholderImage:(UIImage *)placeholderImage;


/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;
/** 本地图片数组 */
@property (nonatomic, strong) NSArray *localizationImageNamesGroup;

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 图片滚动方向，默认为水平滚动 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, weak) id<ZZCycleScrollViewDegelate> delegate;

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

/** block方式监听滚动 */
@property (nonatomic, copy) void (^itemDidScrollOperationBlock)(NSInteger currentIndex);

/** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppera;

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;

/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hidesForSinglePage;

/** pagecontrol 样式，默认为经典样式 */
@property (nonatomic, assign) ZZCycleScrollViewPageContolStyle pageControlStyle;

/** pagecontrol 点的形状*/
@property (nonatomic, assign) ZZPageControlMaginType pageMaginType;

/** 分页控件位置 */
@property (nonatomic, assign) ZZCycleScrollViewPageContolAliment pageControlAliment;

/** 分页控件小圆标大小 */
@property (nonatomic, assign) CGSize pageControlDotSize;

/** 当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageDotColor;

/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

/** 当前分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *currentPageDotImage;

/** 其他分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *pageDotImage;


/** 如果 pagecontrol 样式为YHCycleScrollViewPageContolStyleAnimated 则要设置 以下三属性的值*/
@property (nonatomic) CGFloat indicatorMargin                            UI_APPEARANCE_SELECTOR; // deafult is 10 间距
@property (nonatomic) CGFloat indicatorDiameter                            UI_APPEARANCE_SELECTOR; // deafult is 6 直径
@property (nonatomic) CGFloat normalDiameter                            UI_APPEARANCE_SELECTOR; // deafult is 6 非选中直径宽度 若是圆形，设置跟选中一样

@end

NS_ASSUME_NONNULL_END
