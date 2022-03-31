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
/**
 改变字符串里面包含的所有相同字符串的的颜色和字号
 @param font 大小
 @param color 颜色
 @param totalString 整个字符串
 @param subArray 需要改变字符串的数组
*/
+ (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

/**
 获取当前时间
 */
+ (NSString *)getCurrentData;
/**
 获取当前农历日期
 */
//农历转换函数
+(NSString*)getChineseCalendar;

@end

NS_ASSUME_NONNULL_END
