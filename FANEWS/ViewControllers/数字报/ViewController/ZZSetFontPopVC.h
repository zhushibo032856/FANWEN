//
//  ZZSetFontPopVC.h
//  FANEWS
//
//  Created by fanews on 2022/4/1.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^fontSelectBlock)(NSInteger font);
@interface ZZSetFontPopVC : UIViewController
@property (nonatomic, copy) fontSelectBlock block;
@end

NS_ASSUME_NONNULL_END
