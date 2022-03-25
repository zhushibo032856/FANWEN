//
//  ZZThematicAnalysisVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZThematicAnalysisVC.h"
#import "ZZThematicNormalCell.h"
#import "ZZTextModel.h"
#import "ZZThematicImageCell.h"
@interface ZZThematicAnalysisVC ()<UITableViewDelegate,UITableViewDataSource,ZZCycleScrollViewDegelate>

@property (nonatomic, strong) ZZBaseTableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZZThematicAnalysisVC


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self setRightBt];
    
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
            model.cellHeight = [ZZThematicNormalCell heightWithModel:model];
        }
    //    model.cellHeight = 145;
        [self.dataArr addObject:model];
    }
    [_myTableView reloadData];
}

- (void)setRightBt{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(5, 5, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"Thematic-1"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(navigationRIghtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}

- (void)navigationRIghtEvent:(UIButton *)sender{
//    ZZLoginVC *loginVC = [ZZLoginVC new];
//  //  [self.navigationController pushViewController:loginVC animated:YES];
//    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:loginVC animated:YES completion:nil];
    
    [ZZCommenTools toolPresentLoginVCFrom:self];
}

- (ZZBaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[ZZBaseTableView alloc]initWithFrame:CGRectMake(15, kNavHeight, kScreenWidth - 30, kScreenHeight - kNavHeight - kTabbar_H) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        [_myTableView registerClass:[ZZThematicNormalCell class] forCellReuseIdentifier:@"ZZThematicNormalCell"];
        
        [_myTableView registerClass:[ZZThematicImageCell class] forCellReuseIdentifier:@"ZZThematicImageCell"];
    }
    return _myTableView;
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
        ZZThematicImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZThematicImageCell" forIndexPath:indexPath];

        [cell initCellWith:model];
        return cell;
    }else{
        ZZThematicNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZThematicNormalCell" forIndexPath:indexPath];

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
