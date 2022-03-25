//
//  ZZHomeSearchView.h
//  FANEWS
//
//  Created by fanews on 2022/3/23.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZZHomeSearchViewDelegate <NSObject>

- (void)searchToNextVcWith:(NSString *)text;

@end

@interface ZZHomeSearchView : UIView

/**
 *  delegate
 */
@property (nonatomic, assign)id<ZZHomeSearchViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
