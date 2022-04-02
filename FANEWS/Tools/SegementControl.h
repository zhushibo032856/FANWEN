//
//  SegementControl.h
//  Aetos
//
//  Created by 朱世博 on 2021/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYSegementControllerDelegate <NSObject>

- (void)segementControllerSelectedIndex:(NSInteger)index;

@end

@interface SegementControl : UIView

@property (nonatomic, strong) NSArray <NSString *>*items;

@property (nonatomic, assign) UIEdgeInsets edge;

// each item width
@property (nonatomic, assign) CGFloat itemWidth;

// each item height
@property (nonatomic, assign) CGFloat itemHeight;

// defatule item color
@property (nonatomic, strong) UIColor *defaultColor;

// defatule item index
@property (nonatomic, assign) NSInteger selectedIndex;

// item of seleted color
@property (nonatomic, strong) UIColor *selectColor;

// the bottom line color
@property (nonatomic, strong) UIColor *separatorLineColor;

// each item fontSize
@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) CGFloat boldfontSize;

// delegate
@property (nonatomic, assign) id<YYSegementControllerDelegate> delegate;

// when scrollView slide, recoder newSeleted, if you don not implement the method, scrollView did end decelerating, newSeleted not refresh
- (void)slideChangeSeleted:(NSInteger)newSeleted;

// when scrollView did Scroll, the bottom line also scroll
- (void)scrollViewDidScrollChangeSeparatorLine:(CGFloat)x;

- (void)segementControllShow;

// factory method
+ (instancetype)YYSegementControllerWithFrame:(CGRect)frame;

// init method
- (instancetype)initSegementControllerWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
