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

@interface ZZDigitalNewspaperVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIButton *selectBT;
@property (nonatomic, assign) NSInteger type;

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
    // Do any additional setup after loading the view.
    [self setRightBt];
    
    [self.view addSubview:self.myCollectionView];
}
//设置切换按钮
- (void)setRightBt{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
 //   rightView.backgroundColor = [UIColor redColor];
//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(5, 5, 24, 24);
//    rightBtn.selected = YES;
//    self.isMore = rightBtn.isSelected;
//    [rightBtn setImage:[UIImage imageNamed:@"Thematic-1"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(navigationRIghtEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:rightBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    NSArray *imageArr = @[@"Thematic-1",@"Thematic-1",@"Thematic-1"];
    NSArray *imageSelect = @[@"mine-5",@"mine-5",@"mine-5"];
    CGFloat padding = 5;
    CGFloat titBtnX = 5;
    CGFloat titBtnY = 5;
    CGFloat titBtnH = 20;
    for (int i = 0 ; i < imageArr.count ; i++) {
      //  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.height)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000+i;
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageSelect[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(navigationRIghtEvent:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个选中
        if (i == 0) {
            _selectBT = button;
            button.selected = YES;
        }
        
        [rightView addSubview:button];;
        button.frame=CGRectMake(titBtnX, titBtnY, 20, titBtnH);
        titBtnX += 20 + padding;

    }
}

- (void)navigationRIghtEvent:(UIButton *)sender{

    if (sender != self.selectBT) {
        sender.selected = YES;
        self.selectBT.selected = NO;
        self.selectBT = sender;
    }
    self.type = sender.tag - 1000;
    [_myCollectionView reloadData];
}


//lazy myCollectionView
- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);

        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight - kTabbar_H - kNavHeight)collectionViewLayout:layout];
        _myCollectionView.alwaysBounceVertical = YES;
        _myCollectionView.backgroundColor = [UIColor whiteColor];
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
        return CGSizeMake(floor(kScreenWidth - 20), floor(kScreenWidth - 50) * 1.2);;
    }
    if (self.type == 1) {
        return CGSizeMake(floor((kScreenWidth - 30)/2), floor((kScreenWidth - 30)/2) * 1.2);
    }
    return CGSizeMake(floor((kScreenWidth - 50)/3), floor((kScreenWidth - 50)/3) * 1.2);
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ZZDigitalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZDigitalCell" forIndexPath:indexPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZDigitalDetailVC *vc = [ZZDigitalDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
