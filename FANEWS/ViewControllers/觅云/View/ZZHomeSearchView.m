//
//  ZZHomeSearchView.m
//  FANEWS
//
//  Created by fanews on 2022/3/23.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZHomeSearchView.h"

@interface ZZHomeSearchView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UITextField *searchTF;
@property (nonatomic, strong) UIButton *searchBT;

@end

@implementation ZZHomeSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    self.backView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:self.backView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kColor(204, 221, 255).CGColor,(__bridge id)kColor(255, 255, 255).CGColor];
    gradientLayer.locations = @[@0,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = self.backView.frame;
   // [self.backView.layer addSublayer:gradientLayer];
    [self.backView.layer insertSublayer:gradientLayer atIndex:0];
    
    self.titleImageView = [[UIImageView alloc]init];
    [self.backView addSubview:self.titleImageView];
    self.titleImageView.image = [UIImage imageNamed:@"Erudite-1"];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).offset(80);
        make.centerX.mas_equalTo(self.backView);
        make.height.width.mas_equalTo(180);
    }];
    
    
    self.searchView = [[UIView alloc]init];
    self.searchView.layer.cornerRadius = 23;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor = kColor(86, 141, 229).CGColor;
    [self.backView addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView);
        make.top.mas_equalTo(self.titleImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(46);
    }];
    
    self.searchImageView = [[UIImageView alloc]init];
    [self.searchView addSubview:self.searchImageView];
    self.searchImageView.image = [UIImage imageNamed:@"Erudite-3"];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchView).offset(10);
        make.centerY.mas_equalTo(self.searchView);
        make.height.width.mas_equalTo(24);
    }];
    
    self.searchBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBT setTitle:@"智能检索" forState:UIControlStateNormal];
    [self.searchBT setBackgroundColor:kColor(86, 141, 229)];
    [ZZCommenTools drawTopCornerions:23 with:self.searchBT with:1];
    [self.searchView addSubview:self.searchBT];
    [self.searchBT addTarget:self action:@selector(searchBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchView);
        make.height.mas_equalTo(46);
        make.width.mas_equalTo(108);
        make.right.mas_equalTo(self.searchView);
    }];
    
    self.searchTF = [[UITextField alloc]init];
    self.searchTF.placeholder = @"请输入搜索词";
    [self.searchView addSubview:self.searchTF];
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.searchView);
        make.height.mas_equalTo(46);
        make.right.mas_equalTo(self.searchBT.mas_left);
    }];
    
    
}


- (void)searchBtAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(searchToNextVcWith:)]) {
        [self.delegate searchToNextVcWith:self.searchTF.text];
    }
}

@end
