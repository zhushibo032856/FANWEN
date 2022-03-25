//
//  ZZBaseNavigationController.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZBaseNavigationController.h"

@interface ZZBaseNavigationController ()<UINavigationBarDelegate>

@end

@implementation ZZBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(@available(iOS 13.0,*)) {

            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc]init];
            appearance.backgroundColor = kColor(255, 255, 255);
            appearance.shadowColor = [UIColor clearColor];
            [UINavigationBar appearance].standardAppearance = appearance;
            [UINavigationBar appearance].scrollEdgeAppearance = appearance;

    }else{
        [[UINavigationBar appearance] setBarTintColor:kColor(255, 255, 255)];
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers count] > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
        
    }
    [super pushViewController:viewController animated:YES];
    
}

@end
