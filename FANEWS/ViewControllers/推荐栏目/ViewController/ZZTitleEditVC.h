//
//  ZZTitleEditVC.h
//  FANEWS
//
//  Created by fanews on 2022/3/17.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^titleSelectBlock)(NSInteger index);
@interface ZZTitleEditVC : UIViewController

@property (nonatomic, copy) titleSelectBlock block;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, assign) NSInteger lastIndex;//记录最后移动的下标
@end

NS_ASSUME_NONNULL_END
