//
//  ZZEruditeVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZEruditeVC.h"
#import "ZZMineVC.h"
#import "ZZHomeSearchView.h"

@interface ZZEruditeVC ()<ZZHomeSearchViewDelegate,UITableViewDelegate,UITableViewDataSource,ZZPageButtonDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZZHomeSearchView *searchView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) ZZBaseTableView *tableView;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) ZZPageButtonSelectBaseView *pageView;

/**
 个人信息部分
 */
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNoteLabel;

@end

@implementation ZZEruditeVC

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
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.searchView];
    [self.scrollView addSubview:self.backImageView];
    [self.scrollView addSubview:self.backView];
    [self.backView addSubview:self.tableView];
    [self.backView addSubview:self.pageView];
    [self.searchView addSubview:self.userImageView];
    [self.searchView addSubview:self.userNoteLabel];
}



- (void)searchToNextVcWith:(NSString *)text {
    NSLog(@"%@",text);
    
    if ([ZZCommenTools checkPassWordWith:text] == YES) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
        [MBProgressHUD showError:@""];
    }
}

//lazy
- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbar_H)];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        _scrollView.backgroundColor = [UIColor whiteColor];
        [_scrollView setScrollEnabled:YES];
    //    _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setBounces:NO];
        _scrollView.contentSize = CGSizeMake(0, kScreenHeight * 1.3);
        
        if (@available(iOS 11.0, *)) {
            //系统版本高于11
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _scrollView;
}

- (ZZHomeSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[ZZHomeSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 330)];
        self.searchView.delegate = self;
    }
    return _searchView;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 355, kScreenWidth, 130)];
        _backImageView.backgroundColor = [UIColor cyanColor];
    }
    return _backImageView;
}
//背景图
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 430, kScreenWidth, kScreenHeight * 1.3 - 430)];
        _backView.backgroundColor = [UIColor whiteColor];
        [ZZCommenTools drawTopCornerions:15 with:_backView with:0];
    }
    return _backView;
}
//下方列表
- (ZZPageButtonSelectBaseView *)pageView{
    if (!_pageView) {
        _pageView = [[ZZPageButtonSelectBaseView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
        _pageView.dataArr = [NSMutableArray arrayWithObjects:@"微博热搜榜",@"头条热搜",@"抖音热搜",@"百度热搜",@"人民网热搜榜",@"新华睿思智能榜", nil];
        _pageView.tagTextColor_normal = kColor(36, 59, 76);
        _pageView.tagTextColor_selected = kColor(255, 40, 57);
        _pageView.tagTextFont_normal = 14;
        _pageView.tagTextFont_selected = 14;
        _pageView.delegate = self;
    }
    return _pageView;
}
//代理点击事件
- (void)didSelectedIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}

//用户信息view
- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 35 - 15, 55, 35, 35)];
        _infoView.backgroundColor = [UIColor whiteColor];
    }
    return _infoView;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 32 - 20, 55, 32, 32)];
        _userImageView.image = [UIImage imageNamed:@"Erudite-2"];
        _userImageView.layer.cornerRadius = 8;
        _userImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToMineVC:)];
        [_userImageView addGestureRecognizer:tap];
    }
    return _userImageView;
}


- (void)pushToMineVC:(UITapGestureRecognizer *)tap{
    ZZMineVC *loginVC = [ZZMineVC new];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (UILabel *)userNoteLabel{
    if (!_userNoteLabel) {
        _userNoteLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 20, 55, 8, 8)];
        _userNoteLabel.backgroundColor = kColor(255, 56, 52);
        _userNoteLabel.layer.masksToBounds = YES;
        _userNoteLabel.layer.cornerRadius = 4;
        _userNoteLabel.hidden = YES;
    }
    return _userNoteLabel;
}

#pragma mark tableview 代理
- (ZZBaseTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[ZZBaseTableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight * 1.3 - 490)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}


@end
