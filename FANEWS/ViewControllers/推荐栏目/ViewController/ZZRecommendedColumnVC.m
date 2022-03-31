//
//  ZZRecommendedColumnVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZRecommendedColumnVC.h"
#import "ZZTitleEditVC.h"
#import "ZZRecommenImageCell.h"
#import "ZZRecommenNormalCell.h"

#import "ZZTextModel.h"

@interface ZZRecommendedColumnVC ()<ZZPageControlViewDelegate,UITableViewDelegate,UITableViewDataSource,ZZCycleScrollViewDegelate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) ZZPageControlBaseView *pageView;
@property (nonatomic, strong) UIButton *editBt;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) ZZBaseTableView *myTableView;

@property (nonatomic, assign) NSInteger lastIndex;//记录最后移动的下标

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZZRecommendedColumnVC

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initViewAndDataWith:0];
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.lineLabel];
    
    [self.backView addSubview:self.editBt];
    
    [self.view addSubview:self.myTableView];


    [self getData];
}

- (void)getData{
    NSString *text = @"内容越来越多";
    for (int i = 0; i < 100; i ++) {
        text = [text stringByAppendingString:@"越来越多"];
        ZZTextModel *model = [[ZZTextModel alloc] init];
        model.text = text;
        if (i % 2 == 0) {
            model.isDouble = YES;
            model.cellHeight = 145;
        }else{
            model.isDouble = NO;
            // 计算高度，赋值给model
            model.cellHeight = [ZZRecommenNormalCell heightWithModel:model];
        }
    //    model.cellHeight = 145;
        [self.dataArr addObject:model];
    }
    [_myTableView reloadData];
}

- (void)initViewAndDataWith:(NSInteger)index{
    NSArray *arr = @[@"滚动新闻",@"新闻排行",@"党报头条",@"政府头条",@"畅谈头条",@"法制社会",@"关注中国",@"天下趣闻",@"车驰天下",@"国际视野",@"图说天下",@"旅游小秘",@"军事天地",@"直击财经",@"房产播报",@"时事评论",@"数码科技",@"科学探索",@"文娱时评",@"能源聚宝",@"家居快递",@"时尚娱乐",@"生活百科",@"寻觅美食",@"宅之动漫",@"中医讲堂"];
    
    NSArray *array = KTITLEARR;
    if (array.count == 0) {
        NSLog(@"empty");
        [kUserDefaults setValue:arr forKey:@"TITLEARR"];
        [kUserDefaults synchronize];
        _titleArr = [NSMutableArray arrayWithArray:arr];
    }else{
        _titleArr = [NSMutableArray arrayWithArray:array];
    }
    
    [self initPageViewWith:index];
}


- (void)getTitleDataWith:(NSInteger)index{
    
    [self.pageView removeFromSuperview];
    [self initPageViewWith:index];
    
    
}
- (ZZBaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[ZZBaseTableView alloc]initWithFrame:CGRectMake(15, _backView.bottomY, kScreenWidth - 30, kScreenHeight - kNavHeight - kTabbar_H - 45) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        [_myTableView registerClass:[ZZRecommenNormalCell class] forCellReuseIdentifier:@"ZZRecommenNormalCell"];
        
        [_myTableView registerClass:[ZZRecommenImageCell class] forCellReuseIdentifier:@"ZZRecommenImageCell"];
    }
    return _myTableView;
}

//懒加载头部背景view
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, 45)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
//懒加载头部背景line
- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _backView.height - 1, kScreenWidth, .5)];
        _lineLabel.backgroundColor = kColor(245, 245, 245);
    }
    return _lineLabel;
}

//头部标签view
- (void)initPageViewWith:(NSInteger)index{
    _pageView = [[ZZPageControlBaseView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 44)];
    _pageView.selectIndex = index;
    self.lastIndex = index;
    _pageView.dataArr = _titleArr;
    _pageView.tagTextColor_normal = kColor(50, 50, 50);
    _pageView.tagTextColor_selected = kColor(86, 141, 229);
    _pageView.tagTextFont_normal = 16;
    _pageView.tagTextFont_selected = 16;
    _pageView.sliderColor = kColor(86, 141, 229);
    _pageView.sliderW = 20;
    _pageView.sliderH = 2;
    _pageView.delegate = self;
    [self.backView addSubview:self.pageView];
    
}

//点击代理
- (void)didSelectedIndex:(NSInteger)index{
    self.lastIndex = index;
    NSLog(@"%ld",index);
}

//懒加载右侧展开button
- (UIButton *)editBt{
    if (!_editBt) {
        _editBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBt.frame = CGRectMake(kScreenWidth - 32.5, 10, 25, 25);
        [_editBt setImage:[UIImage imageNamed:@"Recommended-1"] forState:UIControlStateNormal];
        [_editBt addTarget:self action:@selector(editBtAction:) forControlEvents:UIControlEventTouchUpInside];
      //  [_editBt setBackgroundColor:[UIColor whiteColor]];
    }
    return _editBt;
}
//button点击事件
- (void)editBtAction:(UIButton *)sender{
    kWeakSelf
    ZZTitleEditVC *vc = [ZZTitleEditVC new];
    vc.lastIndex = self.lastIndex;
    vc.block = ^(NSInteger index) {
        [weakSelf getTitleDataWith:index];
    };
    vc.titleArr = _titleArr;
    ZZBPPopViewController *popVC = [ZZBPPopViewController initVC:vc];
    
    [self presentViewController:popVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZTextModel *model = self.dataArr[indexPath.row];
 
    return model.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count > 0 ? 1 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZTextModel *model = self.dataArr[indexPath.row];
    if (model.isDouble == YES) {
        ZZRecommenImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZRecommenImageCell" forIndexPath:indexPath];

        [cell initCellWith:model];
        return cell;
    }else{
        ZZRecommenNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZRecommenNormalCell" forIndexPath:indexPath];

        [cell initCellWith:model];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ZZCycleScrollview *cycleView = [ZZCycleScrollview cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@"home_1"]];
    cycleView.backgroundColor = [UIColor whiteColor];
    cycleView.layer.masksToBounds = YES;
    cycleView.layer.cornerRadius = 8;
   // cycleView.localizationImageNamesGroup = @[@"home_1",@"home_1",@"home_1"];

    
  //  if (self.imageArr.count == 0) {
        
        cycleView.imageURLStringsGroup = @[@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg",@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg",@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg",@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg",@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg"];
//    }else{
//        cycleView.imageURLStringsGroup = self.imageArr;
//    }

    cycleView.autoScroll = YES;
  //  cycleView.pageControlStyle = YHCycleScrollViewPageContolStyleNone;
    cycleView.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    cycleView.currentPageDotColor = [UIColor whiteColor];
    cycleView.pageDotColor = [UIColor lightGrayColor];
    cycleView.pageControlDotSize = CGSizeMake(5, 5);
    cycleView.pageControlAliment = ZZCycleScrollViewPageContolAlimentRight;

    cycleView.indicatorMargin = 5;
    cycleView.indicatorDiameter = 5;
    cycleView.normalDiameter = 5.0;
    cycleView.showPageControl = YES;
    
    return cycleView;
    
}

-(void)zz_cycleScrollView:(ZZCycleScrollview *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了%ld",index);

    
}
@end
