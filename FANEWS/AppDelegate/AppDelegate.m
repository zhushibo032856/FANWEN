//
//  AppDelegate.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//

#import "AppDelegate.h"


@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //向微信注册
    [WXApi registerApp:@"" universalLink:@""];
    
    [self setKeyboardManager];
    [self registerNotificationWith:application];
    [self initRootView];
    [self initFpsBT];

    return YES;
}
/**
 初始化键盘
 */
- (void)setKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor =YES; // 控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour =IQAutoToolbarByTag; // 最新版
}

/**
 注册通知
 */
- (void)registerNotificationWith:(UIApplication *)application{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            UNAuthorizationOptions type = UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
            [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError * _Nullable error) {
               NSLog(@"is register");
               if (granted) {
                    NSLog(@"注册成功");
               }else{
                NSLog(@"注册失败");
                }
            }];
            //注册远程通知
            [application registerForRemoteNotifications];
    }
}

/**
 初始化根视图
 */
- (void)initRootView{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ZZBaseTabBarController *vc = [ZZBaseTabBarController new];
    vc.selectedIndex = 2;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

/**
 fps 查看
 */

- (void)initFpsBT{
    OttoFPSButton *btn = [OttoFPSButton setTouchWithFrame:CGRectMake(0, kNavHeight - 30, 80, 30) titleFont:[UIFont systemFontOfSize:14] backgroundColor:kColor(140, 140, 140) backgroundImage:[UIImage imageNamed:@""]];
    [self.window addSubview:btn];
}


+ (AppDelegate *)mainAppDelegate{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}
- (void)showLoginView{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ZZLoginVC *loginVC = [[ZZLoginVC alloc]init];
    loginVC.view.backgroundColor = [UIColor whiteColor];
    loginVC.type = 2;
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
}
- (void)showTabbarView{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ZZBaseTabBarController *vc = [ZZBaseTabBarController new];
    vc.selectedIndex = 2;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

#pragma mark 获取推送token失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册推送失败：%@",error);
}
#pragma mark 获取推送token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"token:%@", deviceToken);
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"deviceToken:%@",hexToken);

}
#pragma mark 收到消息后处理通知
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSLog(@"收到推送内容");
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
        NSLog(@"%@", userInfo);
    }
    
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

#pragma mark App被唤醒后清空通知栏消息
- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"app 被唤醒....");
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OPENSETTING" object:nil];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}


@end
