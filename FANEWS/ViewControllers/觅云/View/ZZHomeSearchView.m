//
//  ZZHomeSearchView.m
//  FANEWS
//
//  Created by fanews on 2022/3/23.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZHomeSearchView.h"

@interface ZZHomeSearchView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *backImageView;
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
    
    self.backImageView = [[UIImageView alloc]init];
    [self.backView addSubview:self.backImageView];
    self.backImageView.userInteractionEnabled = YES;
    self.backImageView.image = [UIImage imageNamed:@"Erudite-4"];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).offset(120);
        make.left.mas_equalTo(self.backView).offset(15);
        make.right.mas_equalTo(self.backView).offset(-15);
        make.height.mas_equalTo(110);
    }];
    
    
    self.searchView = [[UIView alloc]init];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.layer.cornerRadius = 5;
    [self.backImageView addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backImageView.mas_bottom).offset(-15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    self.searchBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBT setImage:[UIImage imageNamed:@"Erudite-3"] forState:UIControlStateNormal];
    [self.searchView addSubview:self.searchBT];
    [self.searchBT addTarget:self action:@selector(searchBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchView);
        make.height.width.mas_equalTo(24);
        make.right.mas_equalTo(self.searchView).offset(-14);
    }];
    
    self.searchTF = [[UITextField alloc]init];
    self.searchTF.delegate = self;
    self.searchTF.placeholder = @"请输入关键词搜索";
    self.searchTF.returnKeyType = UIReturnKeySearch;
    [self.searchView addSubview:self.searchTF];
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchView).offset(10);
        make.centerY.mas_equalTo(self.searchView);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.searchBT.mas_left);
    }];
    
    
}


- (void)searchBtAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(searchToNextVcWith:)]) {
        [self.delegate searchToNextVcWith:self.searchTF.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchToNextVcWith:)]) {
        [self.delegate searchToNextVcWith:self.searchTF.text];
    }
    return YES;
}

@end
