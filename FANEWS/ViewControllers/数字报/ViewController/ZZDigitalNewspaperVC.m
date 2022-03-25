//
//  ZZDigitalNewspaperVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDigitalNewspaperVC.h"

@interface ZZDigitalNewspaperVC ()

@property (nonatomic, strong) ZZBaseWebView *webview;

@end

@implementation ZZDigitalNewspaperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
    [self setRightBt];
    
    self.webview = [[ZZBaseWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavHeight - kTabbar_H)];
    self.webview.htmlString = @"https://www.baidu.com";
    [self.view addSubview:self.webview];
    
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
    ZZLoginVC *loginVC = [ZZLoginVC new];
  //  [self.navigationController pushViewController:loginVC animated:YES];
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end
