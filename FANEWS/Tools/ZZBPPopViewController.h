//
//  ZZBPPopViewController.h
//  Aetos
//
//  Created by 朱世博 on 2021/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZBPPopViewController : UIViewController
@property (nonatomic, strong) UIViewController *contentVC;
+ (ZZBPPopViewController *)initVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
