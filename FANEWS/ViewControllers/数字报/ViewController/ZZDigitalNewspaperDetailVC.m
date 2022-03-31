//
//  ZZDigitalNewspaperDetailVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/31.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDigitalNewspaperDetailVC.h"
#import "ZZDitigalSettingPopVC.h"
@interface ZZDigitalNewspaperDetailVC ()

@end

@implementation ZZDigitalNewspaperDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRightBt];
}

- (void)setRightBt{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(5, 5, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"digital-6"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(navigationRIghtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}

- (void)navigationRIghtEvent:(UIButton *)sender{

    ZZDitigalSettingPopVC *vc = [ZZDitigalSettingPopVC new];
    ZZBPPopViewController *popvc = [ZZBPPopViewController initVC:vc];
    [self presentViewController:popvc animated:YES completion:nil];
}

@end
