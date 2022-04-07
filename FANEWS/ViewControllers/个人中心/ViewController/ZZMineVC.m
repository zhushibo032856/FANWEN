//
//  ZZMineVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZMineVC.h"
#import "ZZMineCell.h"
#import "ZZMineHeadView.h"
#import "ZZLogoutPopVC.h"
#import "ZZMessageCenterVC.h"
#import "ZZEditInfoVC.h"

@interface ZZMineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mineTableView;

@end

@implementation ZZMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"我的";
    
    [self.view addSubview:self.mineTableView];
    [self setRightBt];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"LOGOUT" object:nil];
}

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

#pragma mark 懒加载
- (UITableView *)mineTableView{
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbar_H) style:UITableViewStyleGrouped];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        _mineTableView.rowHeight = 50;
        [_mineTableView registerNib:[UINib nibWithNibName:@"ZZMineCell" bundle:nil] forCellReuseIdentifier:@"ZZMineCell"];
        [_mineTableView registerNib:[UINib nibWithNibName:@"ZZMineHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"ZZMineHeadView"];
        _mineTableView.backgroundColor = kColor(245, 245, 245);
        _mineTableView.showsHorizontalScrollIndicator = NO;
        _mineTableView.showsVerticalScrollIndicator = NO;
        _mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mineTableView;
}
#pragma mark 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageArr = @[@"mine-4",@"mine-5",@"mine-6",@"mine-7",@"mine-8"];
    NSArray *nameArr = @[@"消息中心",@"我的收藏",@"浏览历史",@"意见反馈",@"设置"];
    ZZMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZMineCell" forIndexPath:indexPath];
    cell.typeImageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.nameLabel.text = nameArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.numberLabel.layer.cornerRadius = 7.5;
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.hidden = NO;
    }
    if (indexPath.row == 4) {
        cell.lineLabel.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZZMessageCenterVC *vc = [ZZMessageCenterVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZZMineHeadView *headView = [ZZMineHeadView initMineHeadView];
    kWeakSelf
    headView.block = ^{
        [weakSelf pushToInfoDetailVC];
    };
    [headView initViewWith];
    return headView;
}
#pragma mark 跳转到个人详情页
- (void)pushToInfoDetailVC{

    ZZEditInfoVC *vc = [ZZEditInfoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 15, kScreenWidth, 50);
//    [button setBackgroundColor:[UIColor whiteColor]];
//    [button setTitle:@"退出登录" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(logOutBtAction:) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [footerView addSubview:button];
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark 退出登录
- (void)logOutBtAction:(UIButton *)sender{
    
    ZZLogoutPopVC *vc = [ZZLogoutPopVC new];
    ZZBPPopViewController *popVC = [ZZBPPopViewController initVC:vc];
    [self presentViewController:popVC animated:YES completion:nil];
}
- (void)logout{
    [ZZCommenTools toolPresentLoginVCFrom:self];
}

@end
