//
//  ZZBaseTabBarController.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//
#import "ZZMineVC.h"
#import "ZZBaseTabBarController.h"

@interface ZZBaseTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic ,strong)NSMutableArray * imagesArray;

@end

@implementation ZZBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zzTabbar.translucent = NO;
    [self.zzTabbar setBackgroundColor:[UIColor whiteColor]];
    self.zzTabbar.centerImage = [UIImage imageNamed:@"tabbar-5"];
    self.zzTabbar.centerSelectedImage = [UIImage imageNamed:@"tabbar-6"];
    self.zzTabbar.centerBtn.selected = YES;
    self.delegate = self;
    [self addChildViewControllers];
    
  //  [self getImageArr];
}

- (void)getImageArr{
    self.imagesArray = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        NSMutableArray *images = [NSMutableArray array];
        switch (i) {
            case 0:
                for (int j = 0; j<=10; j++) {
                    NSString *imageName = [NSString stringWithFormat:@"tabbar-6"];
                    [images addObject:(__bridge UIImage *)[UIImage imageNamed:imageName].CGImage];
                }
                break;
            case 1:
                for (int j = 0; j<=10; j++) {
                    NSString *imageName = [NSString stringWithFormat:@"tabbar-6"];
                    [images addObject:(__bridge UIImage *)[UIImage imageNamed:imageName].CGImage];
                }
                break;
            case 2:
                for (int j = 0; j<=10; j++) {
                    NSString *imageName = [NSString stringWithFormat:@"tabbar-6"];
                    [images addObject:(__bridge UIImage *)[UIImage imageNamed:imageName].CGImage];
                }
                break;
            case 3:
                for (int j = 0; j<=13; j++) {
                    NSString *imageName = [NSString stringWithFormat:@"tabbar-6"];
                    [images addObject:(__bridge UIImage *)[UIImage imageNamed:imageName].CGImage];
                }
                break;
            case 4:
                for (int j = 0; j<=13; j++) {
                    NSString *imageName = [NSString stringWithFormat:@"tabbar-6"];
                    [images addObject:(__bridge UIImage *)[UIImage imageNamed:imageName].CGImage];
                }
                break;
            default:
                break;
        }
        [self.imagesArray addObject:images];
    }
}

/** Add tabBarControllers */
- (void)addChildViewControllers {
    
    ZZThematicAnalysisVC *thematicVC = [ZZThematicAnalysisVC new];
    [self addChildViewController:thematicVC image:@"tabbar-2" selectedImage:@"tabbar-1" title:@"专题分析"];
    
    ZZDigitalNewspaperVC *digitalVC = [ZZDigitalNewspaperVC new];
    [self addChildViewController:digitalVC image:@"tabbar-4" selectedImage:@"tabbar-3" title:@"数字报"];
    
    ZZEruditeVC *eruditeVC = [ZZEruditeVC new];
    [self addChildViewController:eruditeVC image:@"" selectedImage:@"" title:@"觅云"];
    
//    ZZIntelligentRetrievalVC *intelligentVC = [ZZIntelligentRetrievalVC new];
//    [self addChildViewController:intelligentVC image:@"tabbar-8" selectedImage:@"tabbar-7" title:@"AI智能检索"];
    
    ZZRecommendedColumnVC *recommendedVC = [ZZRecommendedColumnVC new];
    [self addChildViewController:recommendedVC image:@"tabbar-10" selectedImage:@"tabbar-9" title:@"推荐栏目"];
    
    ZZMineVC *intelligentVC = [ZZMineVC new];
    [self addChildViewController:intelligentVC image:@"tabbar-8" selectedImage:@"tabbar-7" title:@"我的"];
    
}

- (void)addChildViewController:(ZZBaseViewController *)childController image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title{
    
    ZZBaseNavigationController *navigationVC = [[ZZBaseNavigationController alloc] initWithRootViewController:childController];
    
    childController.title = title;

    childController.view.backgroundColor = kColor(255, 255, 255);
    
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
   
    if (@available(iOS 13.0, *)) {
        // iOS13 及以上
        self.tabBar.tintColor = kColor(86, 141, 229);
        self.tabBar.unselectedItemTintColor = kColor(156, 167, 184);
        [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName: kColor(156, 167, 184)} forState:UIControlStateNormal];
        [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName: kColor(86, 141, 229)} forState:UIControlStateSelected];
    }else{

        [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName: kColor(156, 167, 184)} forState:UIControlStateNormal];
        [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName: kColor(86, 141, 229)} forState:UIControlStateSelected];
    }
    
    
    [self addChildViewController:navigationVC];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (tabBarController.selectedIndex != 2) {
        self.zzTabbar.centerBtn.selected = NO;
    }else{
        self.zzTabbar.centerBtn.selected = YES;
    }
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSMutableArray *tabBarBtnArray = [NSMutableArray array];
       int index = [NSNumber numberWithUnsignedInteger:[tabBar.items indexOfObject:item]].intValue;
       // 获取UITabBarButton
       for (int i = 0 ;i < self.tabBar.subviews.count; i++ ) {
           UIView * tabBarButton = self.tabBar.subviews[i];
           if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
               [tabBarBtnArray addObject:tabBarButton];
               // NSLog(@"tabBarButton.sup=%@",[tabBarButton. class]);
           }
       }
       //获取当前的UITabBarButton
       UIView *TabBarButton = tabBarBtnArray[index];
       NSArray *images = self.imagesArray[index];
       for (UIView *imageV in TabBarButton.subviews) {
           if ([imageV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
               CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
               //animation.delegate = self;
               animation.values = images;
               animation.duration = 0.3;// images.count * 0.08;
               animation.calculationMode = kCAAnimationCubic;
               [imageV.layer addAnimation:animation forKey:nil];
           }
       }
}

@end
