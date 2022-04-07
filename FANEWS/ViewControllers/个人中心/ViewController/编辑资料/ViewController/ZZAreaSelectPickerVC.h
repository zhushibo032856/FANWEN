//
//  ZZAreaSelectPickerVC.h
//  FANEWS
//
//  Created by fanews on 2022/4/6.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectAreaBlock)(NSString *aresStr);

@interface ZZAreaSelectPickerVC : UIViewController

@property (nonatomic, copy) SelectAreaBlock block;

@end

NS_ASSUME_NONNULL_END
