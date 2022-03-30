//
//  ZZKeyToLoginVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/30.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZKeyToLoginVC.h"
#import "ZZUserProtocolPrivacyPolicyVC.h"

@interface ZZKeyToLoginVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *loginBT;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *protocolBT;

@end

@implementation ZZKeyToLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initContentView];
}

- (void)initContentView{
    self.loginBT.layer.cornerRadius = 22.5;

    self.textView.delegate = self;
    self.textView.attributedText = [self getContentLabelAttributedText:@"已阅读并同意《中国移动认证服务条款》以及《用户协议》和《隐私政策》"];
   
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kColor(204, 221, 255).CGColor,(__bridge id)kColor(255, 255, 255).CGColor];
    gradientLayer.locations = @[@0,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = self.backView.frame;
   // [self.backView.layer addSublayer:gradientLayer];
    [self.backView.layer insertSublayer:gradientLayer atIndex:0];
}
#pragma mark - UITextViewDelegate ----核心代码

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"userProtocol"]) {
        //《隐私政策》
        NSLog(@"点击了《隐私政策》");
        ZZUserProtocolPrivacyPolicyVC *vc = [ZZUserProtocolPrivacyPolicyVC new];
        vc.urlStr = @"https://www.sogou.com";
        ZZBaseNavigationController *nav = [[ZZBaseNavigationController alloc]initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }else if ([[URL scheme] isEqualToString:@"privacyPolicy"]) {
        //《用户协议》
        NSLog(@"点击了《用户协议》");
        ZZUserProtocolPrivacyPolicyVC *vc = [ZZUserProtocolPrivacyPolicyVC new];
        vc.urlStr = @"https://www.baidu.com";
        vc.type = 1;
        ZZBaseNavigationController *nav = [[ZZBaseNavigationController alloc]initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }else{
        NSLog(@"点击了《中国移动认证服务条款》");
        ZZUserProtocolPrivacyPolicyVC *vc = [ZZUserProtocolPrivacyPolicyVC new];
        vc.urlStr = @"https://www.baidu.com";
        vc.type = 1;
        ZZBaseNavigationController *nav = [[ZZBaseNavigationController alloc]initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }
    return YES;
}
#pragma Others
//----------------------------------
- (NSAttributedString *)getContentLabelAttributedText:(NSString *)text
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kColor(130, 130, 130)}];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kColor(86, 141, 229) range:NSMakeRange(6, 12)];
    [attrStr addAttribute:NSLinkAttributeName value:@"ChinaMobile://" range:NSMakeRange(6, 12)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kColor(86, 141, 229) range:NSMakeRange(20, 6)];
    [attrStr addAttribute:NSLinkAttributeName value:@"privacyPolicy://" range:NSMakeRange(20, 6)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kColor(86, 141, 229) range:NSMakeRange(27, 6)];
    [attrStr addAttribute:NSLinkAttributeName value:@"userProtocol://" range:NSMakeRange(27, 6)];

    return attrStr;
}

- (IBAction)returnBtAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtAction:(UIButton *)sender {
    
}
- (IBAction)selectBtAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

@end
