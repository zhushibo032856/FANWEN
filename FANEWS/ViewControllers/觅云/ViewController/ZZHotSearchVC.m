//
//  ZZHotSearchVC.m
//  FANEWS
//
//  Created by fanews on 2022/4/1.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZHotSearchVC.h"
#import "ZZHotSearchCell.h"
@interface ZZHotSearchVC ()<UITableViewDelegate,UITableViewDataSource,ZZPageButtonDelegate>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) ZZBaseTableView *tableView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) ZZPageButtonSelectBaseView *buttonView;

@end

@implementation ZZHotSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.buttonView];
    [self.backView addSubview:self.tableView];
}
#pragma mark 懒加载
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        _backImageView.image = [UIImage imageNamed:@"Erudite-6"];
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

- (ZZPageButtonSelectBaseView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[ZZPageButtonSelectBaseView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
        _buttonView.dataArr = [NSMutableArray arrayWithObjects:@"微博热搜",@"头条热搜",@"抖音热搜",@"百度热搜",@"知乎热搜", nil];
        _buttonView.tagTextColor_normal = kColor(36, 59, 76);
        _buttonView.tagTextColor_selected = kColor(255, 40, 57);
        _buttonView.tagTextFont_normal = 14;
        _buttonView.tagTextFont_selected = 14;
        _buttonView.delegate = self;
    }
    return _buttonView;
}

- (void)didSelectedIndex:(NSInteger)index{
    
}

- (ZZBaseTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[ZZBaseTableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, self.backView.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setScrollEnabled:NO];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[ZZHotSearchCell class] forCellReuseIdentifier:@"ZZHotSearchCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        if (indexPath.row == 0) {
            return 380;
        }
        return 300;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        return [UIView new];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZHotSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZHotSearchCell" forIndexPath:indexPath];
    [cell setCellWith:indexPath.row];
    return cell;
}

@end
