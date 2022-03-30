//
//  ZZBaseTabBar.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZBaseTabBar.h"
#define ZZTabBarItemHeight    49.0f

@interface ZZBaseTabBar()
@end

@implementation ZZBaseTabBar

- (instancetype)init{
    if (self = [super init]){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //去除选择时高亮
    _centerBtn.adjustsImageWhenHighlighted = NO;
//    _centerBtn.layer.cornerRadius = 17.5;
//    [_centerBtn setBackgroundColor:kColor(86, 141, 229)];
    [self addSubview:_centerBtn];
}

// 设置layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _centerBtn.frame = CGRectMake((kScreenWidth - _centerWidth)/2.0, -_centerHeight/2.0 + self.centerOffsetY + 12, _centerWidth, _centerHeight);
}

- (void)setCenterImage:(UIImage *)centerImage {
    _centerImage = centerImage;
    // 如果设置了宽高则使用设置的大小
    if (self.centerWidth <= 0 && self.centerHeight <= 0){
        //根据图片调整button的位置(默认居中，如果图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
        _centerWidth = 44;
        _centerHeight = 44;
    }
    [_centerBtn setImage:centerImage forState:UIControlStateNormal];

}

- (void)setCenterSelectedImage:(UIImage *)centerSelectedImage {
    _centerSelectedImage = centerSelectedImage;
    [_centerBtn setImage:centerSelectedImage forState:UIControlStateSelected];
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            //返回按钮
            return _centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}

@end
