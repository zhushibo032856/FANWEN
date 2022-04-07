//
//  ZZDateSelectPickerVC.h
//  FANEWS
//
//  Created by fanews on 2022/4/6.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DateSelectBlcok)(NSString *dateStr);
@interface ZZDateSelectPickerVC : UIViewController

@property (nonatomic, copy) DateSelectBlcok blcok;

@end

NS_ASSUME_NONNULL_END
