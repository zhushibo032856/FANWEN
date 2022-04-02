//
//  ZZBaseViewController.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZBaseViewController.h"

@interface ZZBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *netView;


@end

@implementation ZZBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self netWorkingStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setNavigationLeftReturnItem];
    
    __weak typeof (self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
}

- (void)netWorkingStatus{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"无法联网");
                [self setNoNetView];
                break;
            case 1:
                NSLog(@"当前使用的是2g/3g/4g网络");
                [self clearView];
                break;
            case 2:
                NSLog(@"当前在WIFI网络下");
                [self clearView];
                break;
                
            default:
                break;
        }
    }];
}

- (void)setNoNetView{
    [self clearView];
    
    _netView = [[UIView alloc]initWithFrame:self.view.frame];
    _netView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_netView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [_netView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"placeHolder"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_netView);
        make.height.width.mas_equalTo(60);
    }];
    
    UILabel *title = [[UILabel alloc]init];
    [_netView addSubview:title];
    title.text = @"网络不可用,去设置中检查网络连接";
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    }];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    [_netView addSubview:but];
    [but addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_netView);
        make.height.width.mas_equalTo(kScreenWidth);
    }];
}



- (void)clearView{
    [_netView removeFromSuperview];
    [_netView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)goSetting{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
}

- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FontType_Title(17.f),NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)setNavigationLeftReturnItem {

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(-10, -3, 70, 40);
    [leftBtn addTarget:self action:@selector(navigationLeftEvent) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftBtn];
 //   [leftBtn setBackgroundColor:[UIColor redColor]];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 20, 20)];
    image.image = [UIImage imageNamed:@"return"];
    [view addSubview:image];

}


- (void)navigationLeftEvent {
    if (_pushType == isPush)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    else if (_pushType == isPresent)
    {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return;
    }
}

@end
