//
//  ZZPageControl.h
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZZPageControlAlignment) {
    ZZPageControlAlignmentLeft = 1,
    ZZPageControlAlignmentCenter,
    ZZPageControlAlignmentRight
};

typedef NS_ENUM(NSUInteger, ZZPageControlVerticalAlignment) {
    ZZPageControlVerticalAlignmentTop = 1,
    ZZPageControlVerticalAlignmentMiddle,
    ZZPageControlVerticalAlignmentBottom
};

typedef NS_ENUM(NSUInteger,PageControlMaginType) {
    PageControlCircleType = 1,
    PageControlOvalType
};

@interface ZZPageControl : UIControl

@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) CGFloat indicatorMargin                            UI_APPEARANCE_SELECTOR; // deafult is 10 间距
@property (nonatomic) CGFloat indicatorDiameter                            UI_APPEARANCE_SELECTOR; // deafult is 6 直径
@property (nonatomic) CGFloat normalDiameter                            UI_APPEARANCE_SELECTOR; // deafult is 6 非选中直径宽度 若是圆形，设置跟选中一样

@property (nonatomic) ZZPageControlAlignment alignment                    UI_APPEARANCE_SELECTOR; // deafult is Center 显示位置
@property (nonatomic) ZZPageControlVerticalAlignment verticalAlignment    UI_APPEARANCE_SELECTOR;    // deafult is Middle

@property (nonatomic, strong) UIImage *pageIndicatorImage                UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor            UI_APPEARANCE_SELECTOR; // ignored if pageIndicatorImage is set
@property (nonatomic, strong) UIImage *currentPageIndicatorImage        UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor    UI_APPEARANCE_SELECTOR; // ignored if currentPageIndicatorImage is set

@property (nonatomic, assign) PageControlMaginType marginType;
@property (nonatomic) BOOL hidesForSinglePage;            // hide the the indicator if there is only one page. default is NO
@property (nonatomic) BOOL defersCurrentPageDisplay;    // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO

- (void)updateCurrentPageDisplay;                        // update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately

- (CGRect)rectForPageIndicator:(NSInteger)pageIndex;
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

- (void)setImage:(UIImage *)image forPage:(NSInteger)pageIndex;
- (void)setCurrentImage:(UIImage *)image forPage:(NSInteger)pageIndex;
- (UIImage *)imageForPage:(NSInteger)pageIndex;
- (UIImage *)currentImageForPage:(NSInteger)pageIndex;

- (void)updatePageNumberForScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
