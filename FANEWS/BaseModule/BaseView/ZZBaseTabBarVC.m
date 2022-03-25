//
//  ZZBaseTabBarVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZBaseTabBarVC.h"

@interface ZZBaseTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation ZZBaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _zzTabbar = [[ZZBaseTabBar alloc] init];
    
    [_zzTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_zzTabbar forKeyPath:@"tabBar"];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 重写选中事件， 处理中间按钮选中问题
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    _zzTabbar.centerBtn.selected = (tabBarController.selectedIndex == self.viewControllers.count/2);

}

- (void)buttonAction:(UIButton *)button{
    NSInteger count = self.viewControllers.count;
    self.selectedIndex = count/2;//关联中间按钮
    [self tabBarController:self didSelectViewController:self.viewControllers[self.selectedIndex]];
}

@end
