//
//  ZZBaseTabBar.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseTabBar : UITabBar

/**
 中间按钮
 */
@property (nonatomic, strong) UIButton *centerBtn;

/**
  中间按钮图片
 */
@property (nonatomic, strong) UIImage *centerImage;
/**
 中间按钮选中图片
 */
@property (nonatomic, strong) UIImage *centerSelectedImage;
/**
  中间按钮偏移量，默认是居中
 */
@property (nonatomic, assign) CGFloat centerOffsetY;

/**
  中间按钮的宽和高，默认40
*/
@property (nonatomic, assign) CGFloat centerWidth, centerHeight;

@end

NS_ASSUME_NONNULL_END
