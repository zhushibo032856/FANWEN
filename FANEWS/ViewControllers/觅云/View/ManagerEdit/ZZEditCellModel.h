//
//  ZZEditCellModel.h
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,ServeButtonStates) {
    ServeAdd = 0,
    ServeSelected
};

@interface ZZEditCellModel : NSObject

@property (nonatomic, strong) UIColor *backGroundColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) ServeButtonStates state;
@property (nonatomic, assign) BOOL isSectionOne;
@property (nonatomic, assign) BOOL isNewAdd;

@end

NS_ASSUME_NONNULL_END
