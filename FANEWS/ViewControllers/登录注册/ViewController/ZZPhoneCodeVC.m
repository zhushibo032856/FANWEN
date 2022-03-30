//
//  ZZPhoneCodeVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZPhoneCodeVC.h"
#import "ZZFirstSettingPasseordVC.h"

@interface ZZPhoneCodeVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *resetBT;
@property (weak, nonatomic) IBOutlet UIButton *nextBT;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ZZPhoneCodeVC

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownCompleted) name:kLoginCountDownCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownExecutingWithTimeOut:) name:kLoginCountDownExecutingNotification object:nil];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownCompleted) name:kLoginCountDownCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownExecutingWithTimeOut:) name:kLoginCountDownExecutingNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pushType = isPush;
    // Do any additional setup after loading the view from its nib.
    [self initContentView];
    //开始倒计时
    [[ZZNSTimerManager sharedInstance] timerCountDownWithType:CountDownTypeLogin];
}
- (void)initContentView{
    
    self.messageLabel.text = [NSString stringWithFormat:@"验证码已发送至 %@",self.phoneNumber];
    self.nextBT.layer.cornerRadius = 22.5;
    [self.nextBT setEnabled:NO];
    [self.nextBT setBackgroundColor:kColor(155, 188, 237)];
    
    self.codeTF.delegate = self;
    [self.codeTF addTarget:self action:@selector(textFieldPasswordTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kColor(204, 221, 255).CGColor,(__bridge id)kColor(255, 255, 255).CGColor];
    gradientLayer.locations = @[@0,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = self.backView.frame;
   // [self.backView.layer addSublayer:gradientLayer];
    [self.backView.layer insertSublayer:gradientLayer atIndex:0];
}

-(void)textFieldPasswordTextChange:(UITextField *)textField{
    
    if (self.codeTF.text.length > 0) {
        [self.nextBT setEnabled:YES];
        [self.nextBT setBackgroundColor:kColor(89, 143, 226)];
    }else{
        [self.nextBT setEnabled:NO];
        [self.nextBT setBackgroundColor:kColor(155, 188, 237)];
    }
    
}

- (IBAction)changeBtAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[ZZNSTimerManager sharedInstance] cancelTimerWithType:CountDownTypeLogin];
}
- (IBAction)resetCodeBtAction:(UIButton *)sender {
    
}
- (IBAction)nextBtAction:(UIButton *)sender {
    ZZFirstSettingPasseordVC *vc = [ZZFirstSettingPasseordVC new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
  //  [[AppDelegate mainAppDelegate] showTabbarView];
}

#pragma mark - NSNotification 处理倒计时事件

- (void)loginTimerCountDownExecutingWithTimeOut:(NSNotification *)notification {
    NSInteger timeOut = [notification.object integerValue];
    NSString *timeStr = [NSString stringWithFormat:@"%.2ld 秒后重新获取",(long)timeOut];
    self.resetBT.selected = YES;
    [self.resetBT setTitle:timeStr forState:UIControlStateNormal];
    [self.resetBT setTitleColor:kColor(130, 130, 130) forState:UIControlStateNormal];
    self.resetBT.userInteractionEnabled = NO;
}

- (void)loginTimerCountDownCompleted {
    self.resetBT.selected = NO;
    [self.resetBT setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.resetBT setTitleColor:kColor(130, 130, 130) forState:UIControlStateNormal];
    self.resetBT.userInteractionEnabled = YES;
}
- (IBAction)returnBtAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
