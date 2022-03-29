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

@end
