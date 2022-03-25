//
//  ZZBaseWebView.m
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZBaseWebView.h"

@interface ZZBaseWebView ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>



@end

@implementation ZZBaseWebView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self registerHandler];
    }
    return self;
}

-(void)createUI{
    //打开垂直滚动条
    self.scrollView.showsVerticalScrollIndicator=YES;
    //关闭水平滚动条
    self.scrollView.showsHorizontalScrollIndicator=NO;
    //设置滚动视图的背景颜色
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.navigationDelegate = self;
    //两条属性关闭黑影
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, kNavHeight, kScreenWidth, 2);
    self.progressView.trackTintColor = [UIColor redColor]; // 设置进度条的色彩
    //    self.progressView.progressTintColor = [UIColor blueColor];
    // 设置初始的进度
    self.progressView.hidden = NO;
    [self.progressView setProgress:0.1 animated:YES];
    [self addSubview:self.progressView];
    
    _wkWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavHeight + 4, kScreenWidth, self.height)];
    _wkWebview.backgroundColor = [UIColor whiteColor];
    
    _wkWebview.navigationDelegate = self;
    _wkWebview.UIDelegate = self;
    _wkWebview.scrollView.bounces = YES;
    [_wkWebview.scrollView setScrollEnabled:YES];
    [_wkWebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL]; // 进度
    [self addSubview:self.wkWebview];

    // 添加观察者
    
}

- (void)setHtmlString:(NSString *)htmlString{
    kWeakSelf
    _htmlString = htmlString;
   // [_wkWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.htmlString]]];
    [_wkWebview loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:weakSelf.htmlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30]];
}

- (void)registerHandler{
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_wkWebview];
    [_bridge setWebViewDelegate:self];
    
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
