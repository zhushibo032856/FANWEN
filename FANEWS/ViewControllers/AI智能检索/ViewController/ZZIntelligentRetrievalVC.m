//
//  ZZIntelligentRetrievalVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZIntelligentRetrievalVC.h"
#import "ZZAISearchResultVC.h"

@interface ZZIntelligentRetrievalVC ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UITextField *searchTF;
@property (nonatomic, strong) UIButton *searchBT;

@end

@implementation ZZIntelligentRetrievalVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    
    [self creatUI];
}
//创建背景视图
- (void)creatUI{
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbar_H)];
    [self.view addSubview:self.backView];
    
    self.titleImageView = [[UIImageView alloc]init];
    [self.backView addSubview:self.titleImageView];
    self.titleImageView.image = [UIImage imageNamed:@"Erudite-1"];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenWidth);
        make.top.left.right.mas_equalTo(self.backView);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    [self.backView addSubview:self.titleLabel];
    self.titleLabel.text = @"AI智能检索";
    self.titleLabel.font = FontType_Bold(18);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView);
        make.top.mas_equalTo(self.backView).offset(60);
        
    }];

    self.searchView = [[UIView alloc]init];
    self.searchView.layer.cornerRadius = 23;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor = kColor(86, 141, 229).CGColor;
    [self.backView addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView);
        make.top.mas_equalTo(self.backView).offset(370);
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
    [self.searchBT setTitle:@"AI智能检索" forState:UIControlStateNormal];
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
    ZZAISearchResultVC *vc = [ZZAISearchResultVC new];
    vc.searchText = self.searchTF.text;
    [self.navigationController pushViewController:vc animated:YES];
   
}

@end
