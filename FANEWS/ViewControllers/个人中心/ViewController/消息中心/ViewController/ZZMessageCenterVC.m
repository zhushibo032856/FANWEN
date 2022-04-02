//
//  ZZMessageCenterVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/17.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZMessageCenterVC.h"
#import "ZZMessageCenterCell.h"
#import "ZZSystomInfoVC.h"

@interface ZZMessageCenterVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ZZMessageCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息中心";


    [self initView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initView) name:@"OPENSETTING" object:nil];
    
}

- (void)initView{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (@available(iOS 10 , *)){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {//通知开启
                    [self initTableView];
                }else{//通知未开启
                    [self initContentView];
                }
            });
        }];
            
        }
}

- (void)initContentView{
    _titleView = [[UIView alloc]init];
    [self.view addSubview:_titleView];
    _titleView.layer.cornerRadius = 5;
    _titleView.backgroundColor = kColor(245, 245, 245);
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(10 + kNavHeight);
        make.height.equalTo(@85);
    }];
    
    UILabel *pushLabel = [UILabel new];
    [_titleView addSubview:pushLabel];
    pushLabel.text = @"开启推送通知";
    pushLabel.font = FontType_Bold(16);
    [pushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@15);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *detailLabel = [UILabel new];
    [_titleView addSubview:detailLabel];
    detailLabel.text = @"及时接收实时新闻、热门活动等消息";
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.textColor = kColor(102, 102, 102);
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView).offset(15);
        make.top.equalTo(pushLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *closeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleView addSubview:closeBt];
    closeBt.tag = 500;
    [closeBt addTarget:self action:@selector(didSelectBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [closeBt setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleView.mas_right).offset(-10);
        make.centerY.mas_equalTo(_titleView.mas_centerY);
    }];
    
    
    
    UIButton *startBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBt setTitle:@"立即开启" forState:UIControlStateNormal];
    startBt.layer.cornerRadius = 12.5;
    startBt.tag = 600;
    [startBt addTarget:self action:@selector(didSelectBtAction:) forControlEvents:UIControlEventTouchUpInside];
    startBt.titleLabel.font = [UIFont systemFontOfSize:12];
    [startBt setBackgroundColor:kColor(245, 108, 108)];
    [_titleView addSubview:startBt];
    [startBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(closeBt.mas_left).offset(-5);
        make.centerY.mas_equalTo(_titleView.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(70);
    }];
    
    
    
    _myTableView = [[UITableView alloc]init];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 80;
    [_myTableView registerNib:[UINib nibWithNibName:@"ZZMessageCenterCell" bundle:nil] forCellReuseIdentifier:@"ZZMessageCenterCell"];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
    }];
}

- (void)initTableView{
    _myTableView = [[UITableView alloc]init];
    [self.myTableView setScrollEnabled:NO];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 80;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_myTableView registerNib:[UINib nibWithNibName:@"ZZMessageCenterCell" bundle:nil] forCellReuseIdentifier:@"ZZMessageCenterCell"];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZMessageCenterCell" forIndexPath:indexPath];
    NSArray *nameArr = @[@"系统通知",@"活动奖励",@"热门活动"];
    NSArray *imageArr = @[@"tabbar-6",@"mine-2",@"mine-3"];
    cell.nameLabel.text = nameArr[indexPath.row];
    cell.typeImageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        ZZSystomInfoVC *vc = [ZZSystomInfoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 点击事件
- (void)didSelectBtAction:(UIButton *)sender{
    
    if (sender.tag == 500) {
        [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [_titleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }else{
        //[MBProgressHUD showSuccess:@"去设置"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }
    
}



@end
