//
//  ZZUserProtocolPrivacyPolicyVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/24.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZUserProtocolPrivacyPolicyVC.h"

@interface ZZUserProtocolPrivacyPolicyVC ()
@property (nonatomic, strong) ZZBaseWebView *webview;
@end

@implementation ZZUserProtocolPrivacyPolicyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pushType = isPresent;
    if (self.type == 1) {
        self.title = @"用户协议";
    }else{
        self.title = @"隐私政策";
    }
    self.webview = [[ZZBaseWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webview.htmlString = self.urlStr;
    [self.view addSubview:self.webview];
    
    
}


@end
