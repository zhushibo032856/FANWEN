//
//  ZZNSTimerManager.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#define kLoginCountDownCompletedNotification            @"kLoginCountDownCompletedNotification"
#define kFindPasswordCountDownCompletedNotification     @"kFindPasswordCountDownCompletedNotification"
#define kRegisterCountDownCompletedNotification            @"kRegisterCountDownCompletedNotification"
#define kModifyPhoneCountDownCompletedNotification            @"kModifyPhoneCountDownCompletedNotification"

#define kLoginCountDownExecutingNotification            @"kLoginCountDownExecutingNotification"
#define kFindPasswordCountDownExecutingNotification     @"kFindPasswordCountDownExecutingNotification"
#define kRegisterCountDownExecutingNotification            @"kRegisterCountDownExecutingNotification"
#define kModifyPhoneCountDownExecutingNotification            @"kModifyPhoneCountDownExecutingNotification"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CountDownType) {
    CountDownTypeLogin,
    CountDownTypeFindPassword,
    CountDownTypeRegister,
    CountDownTypeModifyPhone,
};


@interface ZZNSTimerManager : NSObject
DEF_SINGLETON(ZZNSTimerManager);

- (void)timerCountDownWithType:(CountDownType)countDownType;

- (void)cancelTimerWithType:(CountDownType)countDownType;
@end

NS_ASSUME_NONNULL_END
