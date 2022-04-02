//
//  ZZHeadlinesVC.m
//  FANEWS
//
//  Created by fanews on 2022/4/1.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZHeadlinesVC.h"
#import "ZZHeadLinesCell.h"

@interface ZZHeadlinesVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) ZZBaseTableView *tableView;
@property (nonatomic, strong) UIView *backView;

@end

@implementation ZZHeadlinesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.tableView];
}
#pragma mark 懒加载
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        _backImageView.image = [UIImage imageNamed:@"Erudite-7"];
    }
    return _backImageView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight * 1.5)];
        _backView.backgroundColor = [UIColor whiteColor];
        [ZZCommenTools drawTopCornerions:16 with:_backView with:0];
    }
    return _backView;
}



- (ZZBaseTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[ZZBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.backView.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setScrollEnabled:NO];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 100;
        [_tableView registerClass:[ZZHeadLinesCell class] forCellReuseIdentifier:@"ZZHeadLinesCell"];
        [ZZCommenTools drawTopCornerions:16 with:_tableView with:0];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZHeadLinesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZHeadLinesCell" forIndexPath:indexPath];
    [cell initCellWith];
    return cell;
}

@end
