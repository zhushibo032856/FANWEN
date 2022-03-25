//
//  ZZSystomInfoVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/17.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZSystomInfoVC.h"
#import "ZZSystomInfoCell.h"
#import "ZZInfoModel.h"

@interface ZZSystomInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZZBaseTableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZZSystomInfoVC

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统通知";
    
    
    [self.view addSubview:self.myTableView];
    
    NSDictionary *dict = @{
        @"height": @"170",
        @"wight": @"70",
        @"UserArr": @[
            @{
                @"name" :@"Jack",
                @"sex" :@"男",
                @"age" : @"20"
            },
            @{
                @"name" :@"li",
                @"sex" :@"女",
                @"age" : @"30"
            }
        ]
    };


    
    ZZPeople *people = [ZZPeople mj_objectWithKeyValues:dict];

    for (User *model in people.UserArr) {
        NSLog(@"%@",model.name);
         [self.dataArr addObject:model];
    }
   
}

//lazy
- (ZZBaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[ZZBaseTableView alloc]initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight - kNavHeight)];
        [_myTableView registerNib:[UINib nibWithNibName:@"ZZSystomInfoCell" bundle:nil] forCellReuseIdentifier:@"ZZSystomInfoCell"];
        _myTableView.estimatedRowHeight = 120;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZSystomInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZSystomInfoCell" forIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}
@end
