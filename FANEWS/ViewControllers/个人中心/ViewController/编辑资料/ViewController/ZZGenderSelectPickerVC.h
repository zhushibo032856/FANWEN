//
//  ZZGenderSelectPickerVC.h
//  FANEWS
//
//  Created by fanews on 2022/4/6.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^genderSelectBlock)(NSString *type);
@interface ZZGenderSelectPickerVC : UIViewController

@property (nonatomic, copy) genderSelectBlock block;

@end

NS_ASSUME_NONNULL_END
