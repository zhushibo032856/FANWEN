//
//  ZZDigitalNewspaperVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDigitalNewspaperVC.h"
#import "ZZDigitalCell.h"
#import "ZZDigitalDetailVC.h"
#import "ZZDigitalNewspaperSliderView.h"

@interface ZZDigitalNewspaperVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIButton *selectBT;
@property (nonatomic, assign) NSInteger type;
/**
 头部背景布局
 */
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *calendarView;
@property (nonatomic, strong) UILabel *calendarLabel;//阴历
@property (nonatomic, strong) UIView *lunarView;
@property (nonatomic, strong) UILabel *lunarLabel;//阳历

@end

@implementation ZZDigitalNewspaperVC

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = kColor(245, 245, 245);
    // Do any additional setup after loading the view.
    [self setRightBt];
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.myCollectionView];
    [self.backView addSubview:self.imageView];
    [self.backView addSubview:self.calendarView];
    [self.backView addSubview:self.calendarLabel];
    [self.backView addSubview:self.lunarView];
    [self.backView addSubview:self.lunarLabel];
    
    [self initChangeBt];
    [self getCurrentDate];
}
//设置切换按钮
- (void)setRightBt{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(5, 5, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"Thematic-1"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(navigationRIghtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}

- (void)navigationRIghtEvent:(UIButton *)sender{

    
}

#pragma mark 设置当前时间
- (void)getCurrentDate{
    
    self.calendarLabel.text = [ZZCommenTools getCurrentData];
    self.lunarLabel.text = [ZZCommenTools getChineseCalendar];
}


//lazy myCollectionView
- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 15;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavHeight + 80, kScreenWidth, kScreenHeight - kTabbar_H - kNavHeight - 80)collectionViewLayout:layout];
        _myCollectionView.alwaysBounceVertical = YES;
        _myCollectionView.backgroundColor = [UIColor clearColor];
        [_myCollectionView registerNib:[UINib nibWithNibName:@"ZZDigitalCell" bundle:nil] forCellWithReuseIdentifier:@"ZZDigitalCell"];

        
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
    }
    return _myCollectionView;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        return CGSizeMake(floor((kScreenWidth - 35)/2), floor((kScreenWidth - 35)/2) * 1.3);
    }
    return CGSizeMake(floor((kScreenWidth - 50)/3), floor((kScreenWidth - 50)/3) * 1.3);
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ZZDigitalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZDigitalCell" forIndexPath:indexPath];

    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.kfzimg.com/sw/kfzimg/946/a7d1640ef02f455d_b.jpg"]];
    cell.collectionBT.tag = 5000 + indexPath.item;
    [cell.collectionBT addTarget:self action:@selector(collectionBtAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZDigitalNewspaperSliderView *vc = [ZZDigitalNewspaperSliderView new];
    vc.calendarStr = [ZZCommenTools getCurrentData];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 收藏操作
 */
- (void)collectionBtAction:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    
}


//lazy
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, 160)];
     
    }
    return _backView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
        _imageView.image = [UIImage imageNamed:@"digital-5"];
    }
    return _imageView;
}

- (UIView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[UIView alloc]initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 24)];
        _calendarView.layer.cornerRadius = 12;
        _calendarView.backgroundColor = kColor(100, 100, 100);
        _calendarView.alpha = 0.3;
    }
    return _calendarView;
}
- (UILabel *)calendarLabel{
    if (!_calendarLabel) {
        _calendarLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, kScreenWidth - 190, 24)];
        
        _calendarLabel.textColor = [UIColor whiteColor];
        _calendarLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _calendarLabel;
}

- (UIView *)lunarView{
    if (!_lunarView) {
        _lunarView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 150 - 15, 50, 150, 24)];
        _lunarView.layer.cornerRadius = 12;
        _lunarView.backgroundColor = kColor(0, 0, 0);
        _lunarView.alpha = 0.15;
    }
    return _lunarView;
}
- (UILabel *)lunarLabel{
    if (!_lunarLabel) {
        _lunarLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 150 - 15, 50, 150, 24)];
        _lunarLabel.textColor = [UIColor whiteColor];
        _lunarLabel.font = [UIFont systemFontOfSize:12];
        _lunarLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lunarLabel;
}

- (void)initChangeBt{
        NSArray *imageArr = @[@"digital-3",@"digital-1"];
        NSArray *imageSelect = @[@"digital-4",@"digital-2"];
        CGFloat padding = 5;
        CGFloat titBtnX = 5;
        CGFloat titBtnY = 15;
        CGFloat titBtnH = 20;
        for (int i = 1 ; i < imageArr.count ; i--) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 1000+i;
            [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:imageSelect[i]] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(didSelectBtAction:) forControlEvents:UIControlEventTouchUpInside];
            //默认第一个选中
            if (i == 0) {
                _selectBT = button;
                button.selected = YES;
            }
    
            [self.backView addSubview:button];;
            button.frame=CGRectMake(kScreenWidth - titBtnX - 30, titBtnY, 20, titBtnH);
            titBtnX += 20 + padding;
    
        }
}

- (void)didSelectBtAction:(UIButton *)sender{
    if (sender != self.selectBT) {
        sender.selected = YES;
        self.selectBT.selected = NO;
        self.selectBT = sender;
    }
    
    self.type = sender.tag - 1000;
    [_myCollectionView reloadData];
}

@end
