//
//  ZZWelcomeVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/30.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZWelcomeVC.h"

@interface ZZWelcomeVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation ZZWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.pageControl = [UIPageControl new];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-60);
    }];
    [self loadPhoto];
}

- (void)loadPhoto
{
    
    
    //加载图片, 可以在这网络请求
    NSArray *configArr = @[@"launch",@"launch",@"launch",@"launch"];
    
    for (int i = 0; i < configArr.count; i ++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        //用SDWebImage下载图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:configArr[i]]];
        imageView.image = [UIImage imageNamed:configArr[i]];
        
        [self.scrollView addSubview:imageView];
        if (i == configArr.count - 1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
        }
    }
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight);
    
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

- (void)tapImage:(UITapGestureRecognizer *)sender{
    self.callBack();
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

//pageControl状态
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x < kScreenWidth * 0.5) {
        self.pageControl.currentPage = 0;
    }else if(self.scrollView.contentOffset.x > kScreenWidth * 0.5 && self.scrollView.contentOffset.x < kScreenWidth * 1.5)
    {
        self.pageControl.currentPage = 1;
    }else if(self.scrollView.contentOffset.x > kScreenWidth * 1.5 && self.scrollView.contentOffset.x < kScreenWidth * 2.5){
        self.pageControl.currentPage = 2;
    }else if(self.scrollView.contentOffset.x > kScreenWidth * 2.5){
        self.pageControl.currentPage = 3;
    }
}

@end
