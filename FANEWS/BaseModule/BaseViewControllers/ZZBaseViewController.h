//
//  ZZBaseViewController.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PushType) {
    isPush,
    isPresent
};

@interface ZZBaseViewController : UIViewController
/** 跳转类型 */
@property (nonatomic, assign) PushType pushType;
/**
 导航栏左上角返回Item
 */
- (void)setNavigationLeftReturnItem;


@end

NS_ASSUME_NONNULL_END
