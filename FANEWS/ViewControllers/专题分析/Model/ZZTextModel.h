//
//  ZZTextModel.h
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZTextModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, assign) BOOL isDouble;

@end

NS_ASSUME_NONNULL_END
