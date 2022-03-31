//
//  ZZCommenTools.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZCommenTools.h"

@implementation ZZCommenTools

+ (void)toolPresentLoginVCFrom:(UIViewController *)vc{
    ZZLoginVC *loginVC = [ZZLoginVC new];
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:loginVC animated:YES completion:nil];
    
}

+ (void)drawTopCornerions:(CGFloat)cornerRadius with:(UIView *)maskView with:(NSInteger)type{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBezierPath *maskPath;
        if (type == 0) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:maskView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }else if (type == 1){
            maskPath = [UIBezierPath bezierPathWithRoundedRect:maskView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }else if (type == 2){
            maskPath = [UIBezierPath bezierPathWithRoundedRect:maskView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
        
        
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        
        maskLayer.frame = maskView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        maskView.layer.mask = maskLayer;
    });
}

+ (BOOL)checkPhoneNumberWith:(NSString *)phone{
    NSString *mobile = @"^(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [pred evaluateWithObject:phone];
}

+ (void)drawUITextfiled:(UITextField *)textfield with:(UIColor *)color{
    textfield.layer.borderColor = color.CGColor;
    textfield.layer.borderWidth = 0.5;
    textfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
}

+ (BOOL)checkPassWordWith:(NSString *)passWord{
    
    NSString *regex = @"^(?![A-Za-z0-9]+$)(?![a-z0-9\\W]+$)(?![A-Za-z\\W]+$)(?![A-Z0-9\\W]+$)[a-zA-Z0-9\\W]{8,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:passWord] ;
}


#pragma mark - 获取这个字符串中的所有xxx的所在的index
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {//去掉这个xxx
                
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}

/**
 
 改变字符串里面包含的所有相同字符串的的颜色和字号
 @param font 大小
 @param color 颜色
 @param totalString 整个字符串
 @param subArray 需要改变字符串的数组
 
 */
+ (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    
    NSLog(@"zsp===%@ 777%@",totalString,subArray);
    
    NSArray *result = [subArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"result===888%@",result);
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    for (int index=0; index<result.count; index++) {
        NSString *cstrTemp = result[index];
        NSMutableArray *locationArr = [self getRangeStr:totalString findText:cstrTemp];
        NSLog(@"locationArr====%@",locationArr);
        for (int i=0; i<locationArr.count; i++) {
            NSNumber *location = locationArr[i];
            NSRange rang =NSMakeRange(location.integerValue, cstrTemp.length);
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:rang];
            [attributedStr addAttribute:NSFontAttributeName value:font range:rang];
        }
    }
    return attributedStr;
}

/**
 获取当前时间
 */
+ (NSString *)getCurrentData{
    NSString *string;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //下面是单独获取每项的值
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    //星期 注意星期是从周日开始计算
    NSInteger week = [comps weekday];
    //年
    NSInteger year = [comps year];
    //月
    NSInteger month = [comps month];
    //日
    NSInteger day = [comps day];
    NSString *weekDay;
    switch (week) {
        case 1:
            weekDay = @"星期日";
            break;
        case 2:
            weekDay = @"星期一";
            break;
        case 3:
            weekDay = @"星期二";
            break;
        case 4:
            weekDay = @"星期三";
            break;
        case 5:
            weekDay = @"星期四";
            break;
        case 6:
            weekDay = @"星期五";
            break;
        case 7:
            weekDay = @"星期六";
            break;
        default:
            break;
    }
    string = [NSString stringWithFormat:@"  %ld年%ld月%ld日     %@",year,month,day,weekDay];
    return string;
}


//农历转换函数
+(NSString*)getChineseCalendar{
    NSDate *date = [NSDate date];
    NSArray *chineseYears = [NSArray arrayWithObjects:
                       @"甲子", @"乙丑", @"丙寅",    @"丁卯",    @"戊辰",    @"己巳",    @"庚午",    @"辛未",    @"壬申",    @"癸酉",
                       @"甲戌",    @"乙亥",    @"丙子",    @"丁丑", @"戊寅",    @"己卯",    @"庚辰",    @"辛己",    @"壬午",    @"癸未",
                       @"甲申",    @"乙酉",    @"丙戌",    @"丁亥",    @"戊子",    @"己丑",    @"庚寅",    @"辛卯",    @"壬辰",    @"癸巳",
                       @"甲午",    @"乙未",    @"丙申",    @"丁酉",    @"戊戌",    @"己亥",    @"庚子",    @"辛丑",    @"壬寅",    @"癸丑",
                       @"甲辰",    @"乙巳",    @"丙午",    @"丁未",    @"戊申",    @"己酉",    @"庚戌",    @"辛亥",    @"壬子",    @"癸丑",
                       @"甲寅",    @"乙卯",    @"丙辰",    @"丁巳",    @"戊午",    @"己未",    @"庚申",    @"辛酉",    @"壬戌",    @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                        @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                        @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                      @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                      @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                      @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
 
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%ld_%ld_%ld  %@",(long)localeComp.year,(long)localeComp.month,(long)localeComp.day, localeComp.date);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
 
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@年%@%@",y_str,m_str,d_str];
    
 
    
    return chineseCal_str;
}


@end
