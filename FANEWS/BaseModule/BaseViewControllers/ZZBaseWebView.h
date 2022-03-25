//
//  ZZBaseWebView.h
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseWebView : WKWebView

@property(nonatomic,strong)WKWebView * wkWebview;

@property(nonatomic,strong)NSString * htmlString;

@property(nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@property (strong, nonatomic) UIProgressView *progressView;
@end

NS_ASSUME_NONNULL_END
