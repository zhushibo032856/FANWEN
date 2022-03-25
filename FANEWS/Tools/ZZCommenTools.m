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

@end
