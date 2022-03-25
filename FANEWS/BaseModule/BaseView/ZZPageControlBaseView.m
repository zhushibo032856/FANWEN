//
//  ZZPageControlBaseView.m
//  FANEWS
//
//  Created by fanews on 2022/3/17.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZPageControlBaseView.h"

#define DefaultTagTextColor_normal [UIColor blackColor]
#define DefaultTagTextColor_selected [UIColor blueColor]
#define DefaultTagTextFont_normal 17
#define DefaultTagTextFont_selected 19
#define DefaultSliderColor [UIColor blueColor]
#define DefaultSliderH 1
#define DefaultSliderW 30

@interface ZZPageControlBaseView ()

@property (nonatomic, strong) NSMutableArray * buttonsArray;
@property (nonatomic, strong) UIView * sliderView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ZZPageControlBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _buttonsArray = [[NSMutableArray alloc] init];
        
        //默认
        _tagTextColor_normal = DefaultTagTextColor_normal;
        _tagTextColor_selected = DefaultTagTextColor_selected;
        _tagTextFont_normal = DefaultTagTextFont_normal;
        _tagTextFont_selected = DefaultTagTextFont_selected;
        _sliderColor = DefaultSliderColor;
        _sliderH = DefaultSliderH;
        _sliderW = DefaultSliderW;
        
    }
    return self;
}

- (void)createUI
{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setBounces:NO];
    [self addSubview:self.scrollView];
   
    [self.buttonsArray removeAllObjects];
    float width = 90;
    CGFloat maxY = 0.0;
    for (int i = 0 ; i < _dataArr.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.height)];
        button.tag = 1000+i;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[_dataArr objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:self.tagTextColor_normal forState:UIControlStateNormal];
        [button setTitleColor:self.tagTextColor_selected forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
        button.titleLabel.numberOfLines = 0;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个选中
        if (i == _selectIndex) {
            button.selected = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
        }
        
        [self.buttonsArray addObject:button];
        [self.scrollView addSubview:button];
        maxY += width;
    }
    
    self.scrollView.contentSize = CGSizeMake(maxY, 0);
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-self.sliderH, self.sliderW, self.sliderH)];
    self.sliderView.centerX = width/2;
    self.sliderView.backgroundColor = self.sliderColor;
    [self.scrollView addSubview:self.sliderView];
    if (_selectIndex < 1) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(width * _selectIndex - 110, 0) animated:YES];
    }
    
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 0.5, maxY, 0.5)];
    lineLabel.backgroundColor = kColor(240, 240, 240);
 //   [self.scrollView addSubview:lineLabel];
}

- (void)tagBtnClick:(UIButton *)btn
{
    kWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.sliderView.centerX = btn.centerX;
    }];
    
    for (UIButton *subButton in self.buttonsArray) {
        subButton.selected = NO;
        subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
    }
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:btn.tag -1000];
    }
    
    [self setBtnCenter:btn];
}

- (void)selectingOneTagWithIndex:(NSInteger)index
{
    NSInteger s_btnTagIndex = index+1000;
    for (UIButton *subButton in self.buttonsArray) {
        if (s_btnTagIndex != subButton.tag) {
            subButton.selected = NO;
            subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
        }
        else{
            kWeakSelf;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.sliderView.centerX = subButton.centerX;
            } completion:^(BOOL finished) {
                subButton.selected = YES;
                subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
            }];
        }
    }
}

// 让选中的按钮居中显示
- (void)setBtnCenter:(UIButton *)sender
{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = sender.center.x - self.frame.size.width * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.frame.size.width + 10;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

- (void)setDataArr:(NSMutableArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
        [self createUI];
    }
}
- (void)setTagTextColor_normal:(UIColor *)tagTextColor_normal
{
    if (_tagTextColor_normal != tagTextColor_normal) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:tagTextColor_normal forState:UIControlStateNormal];
        }
        _tagTextColor_normal = tagTextColor_normal;
    }
}
- (void)setTagTextColor_selected:(UIColor *)tagTextColor_selected
{
    if (_tagTextColor_selected != tagTextColor_selected) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:tagTextColor_selected forState:UIControlStateSelected];
        }
        _tagTextColor_selected = tagTextColor_selected;
    }
}
- (void)setTagTextFont_normal:(CGFloat)tagTextFont_normal
{
    if (_tagTextFont_normal != tagTextFont_normal) {
        for (UIButton *subButton in self.buttonsArray){
            if (subButton.selected == NO) {
                subButton.titleLabel.font = [UIFont systemFontOfSize:tagTextFont_normal] ;
            }
        }
        _tagTextFont_normal = tagTextFont_normal;
    }
}
- (void)setTagTextFont_selected:(CGFloat)tagTextFont_selected
{
    if (_tagTextFont_selected != tagTextFont_selected) {
        for (UIButton *subButton in self.buttonsArray){
            if (subButton.selected == YES) {
                subButton.titleLabel.font = KUIFont(tagTextFont_selected) ;
            }
        }
        _tagTextFont_selected = tagTextFont_selected;
    }
}
- (void)setSliderColor:(UIColor *)sliderColor
{
    if (_sliderColor != sliderColor) {
        self.sliderView.backgroundColor = sliderColor;
        _sliderColor = sliderColor;
    }
}
- (void)setSliderW:(CGFloat)sliderW
{
    if (_sliderW != sliderW) {
        self.sliderView.width = sliderW;
        _sliderW = sliderW;
    }
}
- (void)setSliderH:(CGFloat)sliderH
{
    if (_sliderH != sliderH) {
        self.sliderView.height = sliderH;
        self.sliderView.Y = self.height-self.sliderView.height;
        for (UIButton *subButton in self.buttonsArray){
            if (subButton.selected == YES) {
                self.sliderView.centerX = subButton.centerX;
            }
        }
        _sliderH = sliderH;
    }
}

@end
