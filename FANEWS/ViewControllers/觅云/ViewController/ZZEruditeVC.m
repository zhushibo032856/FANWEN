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
#import "SegementControl.h"
#import "ZZMediaHotVC.h"
#import "ZZHeadlinesVC.h"
#import "ZZHotSearchVC.h"
#import "ZZPopSettingCell.h"
#import "ZZApplicationManagementVC.h"

@interface ZZEruditeVC ()<ZZHomeSearchViewDelegate,YYSegementControllerDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZZHomeSearchView *searchView;
/**
 我的应用
 */
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) SegementControl *segementControl;
@property (nonatomic, strong) UIScrollView *categoryScrollview;
/**
 个人信息部分
 */
@property (nonatomic, strong) UILabel *userNameLabel;
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
    
    
    
    [self setChildView];
    [self creatTitleView];
}

- (void)setChildView{
    
    ZZHotSearchVC *hotVC = [ZZHotSearchVC new];
    [self addChildViewController:hotVC];
    
    ZZHeadlinesVC *headVC = [ZZHeadlinesVC new];
    [self addChildViewController:headVC];
    
    ZZMediaHotVC *mediaVC = [ZZMediaHotVC new];
    [self addChildViewController:mediaVC];
}

- (void)creatTitleView{
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.searchView];
    [self.searchView addSubview:self.userImageView];
    [self.searchView addSubview:self.userNoteLabel];
    _userNoteLabel.hidden = YES;
    [self.searchView addSubview:self.userNameLabel];
    
    self.userNameLabel.text = @"江都融媒体中心";
    
    [self.scrollView addSubview:self.myView];
    [self.myView addSubview:self.myButton];
    [self.myView addSubview:self.myLabel];
    [self.myView addSubview:self.collectionView];
    [self.myView addSubview:self.lineView];
    
    [self.scrollView addSubview:self.segementControl];
    [self.scrollView addSubview:self.categoryScrollview];
    
    [self showVC:0];
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
        _scrollView.contentSize = CGSizeMake(0, kScreenHeight * 1.5);
        
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
//头部搜索视图
- (ZZHomeSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[ZZHomeSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
        self.searchView.delegate = self;
    }
    return _searchView;
}
//delegate
- (void)searchToNextVcWith:(NSString *)text {
    NSLog(@"%@",text);
    
    if ([ZZCommenTools checkPassWordWith:text] == YES) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
    }
}

//用户信息view

- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 150 , 25)];
        _userNameLabel.font = FontType_Bold(18);
        _userNameLabel.textColor = [UIColor blackColor];
    }
    return _userNameLabel;
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
    
    self.tabBarController.selectedIndex = 4;
    
}

- (UILabel *)userNoteLabel{
    if (!_userNoteLabel) {
        _userNoteLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 20, 55, 8, 8)];
        _userNoteLabel.backgroundColor = kColor(255, 56, 52);
        _userNoteLabel.layer.masksToBounds = YES;
        _userNoteLabel.layer.cornerRadius = 4;
        
    }
    return _userNoteLabel;
}


- (void)showVC:(NSInteger)index {
    
    CGFloat offsetX = index * kScreenWidth;
    UIViewController *VC = self.childViewControllers[index];
    if (VC.isViewLoaded) return;
    [self.categoryScrollview addSubview:VC.view];
    VC.view.frame = CGRectMake(offsetX, 0, kScreenWidth, self.categoryScrollview.height);
}

- (void)segementControllerSelectedIndex:(NSInteger)index {
    
    [self showVC:index];
    [self.categoryScrollview setContentOffset:CGPointMake(index * kScreenWidth, 0) animated:NO];
}


#pragma mark -- UIScrollViewDelegate --

// 只要scrollView滚动就会调用，（不管是setContentOffset还是手动滑动）
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
    if (scrollView == self.categoryScrollview) {
        [self.segementControl scrollViewDidScrollChangeSeparatorLine:scrollView.contentOffset.x];
    }
    
}


// 只有手动滑动停止才会调用，setContentOffset方法不会调用此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = (NSInteger)scrollView.contentOffset.x / kScreenWidth;
    [self showVC:index];
    [self.segementControl slideChangeSeleted:index];
}


- (SegementControl *)segementControl {
    
    if (!_segementControl) {
        self.segementControl = [SegementControl YYSegementControllerWithFrame:(CGRectMake(0, 360, kScreenWidth * 0.75, 40))];
        self.segementControl.edge = UIEdgeInsetsMake(0, 0, 0, 10);
        self.segementControl.itemHeight = 40;
        self.segementControl.selectColor = kColor(86, 141, 229);
        self.segementControl.defaultColor = kColor(101, 101, 101);
        self.segementControl.items = @[@"热搜榜",@"头条",@"媒体热点"];
        self.segementControl.selectedIndex = 0;
        self.segementControl.delegate = self;
        self.segementControl.separatorLineColor = kColor(86, 141, 229);
        self.segementControl.fontSize = 16.f;
        self.segementControl.boldfontSize = 18.f;
        [self.segementControl segementControllShow];
    }
    return _segementControl;
}


- (UIScrollView *)categoryScrollview{
    
    if (!_categoryScrollview) {
        _categoryScrollview = [[UIScrollView alloc] init];
        [_categoryScrollview setFrame:CGRectMake(0, 400, kScreenWidth, kScreenHeight * 1.5 - kTabbar_H - 400 + kNavHeight)];
        [_categoryScrollview setScrollEnabled:YES];
        _categoryScrollview.backgroundColor = [UIColor whiteColor];
        _categoryScrollview.contentSize = CGSizeMake(kScreenWidth * 3, _categoryScrollview.height);
        [_categoryScrollview setShowsHorizontalScrollIndicator:NO];
        [_categoryScrollview setPagingEnabled:YES];
        [_categoryScrollview setBounces:NO];
        _categoryScrollview.delegate = self;
    }
    return _categoryScrollview;
}

#pragma mark uicollectionview

- (UIView *)myView{
    if (!_myView) {
        _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 240, kScreenWidth, 120)];
    }
    return _myView;
}

- (UILabel *)myLabel{
    if (!_myLabel) {
        _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
        _myLabel.text = @"我的应用";
        _myLabel.font = FontType_Bold(14);
    }
    return _myLabel;
}
- (UIButton *)myButton{
    if (!_myButton) {
        _myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myButton.frame = CGRectMake(kScreenWidth - 70, 10, 60, 20);
        [_myButton setImage:[UIImage imageNamed:@"Erudite-8"] forState:UIControlStateNormal];
        [_myButton setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
        [_myButton setTitle:@"管理" forState:UIControlStateNormal];
        [_myButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _myButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_myButton addTarget:self action:@selector(pushManagerVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myButton;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 80) collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZPopSettingCell" bundle:nil] forCellWithReuseIdentifier:@"ZZPopSettingCell"];
        [_collectionView setScrollEnabled:NO];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, kScreenWidth, 5)];
        _lineView.backgroundColor = kColor(245, 245, 245);
    }
    return _lineView;
}

#pragma mark 管理页面
- (void)pushManagerVC{
    ZZApplicationManagementVC *vc = [ZZApplicationManagementVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(floor((kScreenWidth - 90)/5), floor((kScreenWidth - 90)/5 * 1.2));
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ZZPopSettingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZPopSettingCell" forIndexPath:indexPath];
    NSArray *nameArr = @[@"智能检索",@"杭州新闻",@"杭州地铁",@"杭州亚运",@"林草栏目"];
    NSArray *imageArr = @[@"Erudite-9",@"Erudite-10",@"Erudite-11",@"Erudite-13",@"Erudite-12"];

    cell.typeImage.image = [UIImage imageNamed:imageArr[indexPath.item]];
    cell.titleLabel.text = nameArr[indexPath.item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
}











- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
