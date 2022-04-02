//
//  ZZDigitalNewspaperDetailVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/31.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDigitalNewspaperDetailVC.h"
#import "ZZDitigalSettingPopVC.h"
#import "ZZSetFontPopVC.h"
@interface ZZDigitalNewspaperDetailVC ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *wkWebview;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation ZZDigitalNewspaperDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRightBt];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.wkWebview];
    [self.wkWebview loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setFontVC) name:@"SETTINGDISMISS" object:nil];
}

- (void)setFontVC{
    ZZSetFontPopVC *vc = [ZZSetFontPopVC new];
    kWeakSelf
    vc.block = ^(NSInteger font) {
        [weakSelf setWebFontWith:font];
    };
    ZZBPPopViewController *popvc = [ZZBPPopViewController initVC:vc];
    [self presentViewController:popvc animated:YES completion:nil];
}

#pragma mark 设置字体
- (void)setWebFontWith:(NSInteger)font{
    if (font == 0) {
            [_wkWebview evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '87%'" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
            }];
    }else if (font == 1){
        [_wkWebview evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    
        }];
    }else if (font == 2){
        [_wkWebview evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '125%'" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    
        }];
    }else{
        [_wkWebview evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    
        }];
    }
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

- (WKWebView *)wkWebview{
    if (!_wkWebview) {
        _wkWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavHeight + 4, kScreenWidth, kScreenHeight - kNavHeight - 4)];
        //打开垂直滚动条
        _wkWebview.scrollView.showsVerticalScrollIndicator=YES;
        //关闭水平滚动条
        _wkWebview.scrollView.showsHorizontalScrollIndicator=NO;
        //设置滚动视图的背景颜色
        _wkWebview.scrollView.backgroundColor = [UIColor whiteColor];
        //两条属性关闭黑影
        _wkWebview.opaque = NO;
        
        _wkWebview.backgroundColor = [UIColor whiteColor];
        
        _wkWebview.navigationDelegate = self;
        _wkWebview.UIDelegate = self;
        _wkWebview.scrollView.bounces = YES;
        [_wkWebview.scrollView setScrollEnabled:YES];
        [_wkWebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL]; // 进度
        
    }
    return _wkWebview;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, kNavHeight + 2, kScreenWidth, 2);
        _progressView.trackTintColor = [UIColor redColor]; // 设置进度条的色彩
        _progressView.progressTintColor = [UIColor blueColor];
        // 设置初始的进度
        _progressView.hidden = NO;
        [_progressView setProgress:0.1 animated:YES];
    }
    return _progressView;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@",error);
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"finish----------");
//    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//
//    }];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@",error);
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}
#pragma mark - 监听加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == _wkWebview) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.wkWebview.estimatedProgress animated:YES];
            if(self.wkWebview.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


// 当对象即将销毁的时候调用
- (void)dealloc {
    NSLog(@"webView释放");
    [_wkWebview removeObserver:self forKeyPath:@"estimatedProgress"];
    _wkWebview.navigationDelegate = nil;
    _wkWebview.UIDelegate = nil;
}

@end
