//
//  ZZCommenTools.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZCommenTools : NSObject
/**
 跳转到登录
 */
+ (void)toolPresentLoginVCFrom:(UIViewController *)vc;
/**
 绘制圆角
 */
+ (void)drawTopCornerions:(CGFloat)cornerRadius with:(UIView *)maskView with:(NSInteger)type;
/**
 校验手机号
 */
+ (BOOL)checkPhoneNumberWith:(NSString *)phone;
/**
 UITextField 输入时偏移
 */
+ (void)drawUITextfiled:(UITextField *)textfield with:(UIColor *)color;
/**
 校验密码格式，同时包含大小写字母数字和特殊符号，最小长度
 */
+ (BOOL)checkPassWordWith:(NSString *)passWord;

@end

NS_ASSUME_NONNULL_END
