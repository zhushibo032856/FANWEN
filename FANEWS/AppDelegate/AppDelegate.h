//
//  AppDelegate.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

+ (AppDelegate *)mainAppDelegate;

- (void)showLoginView;
- (void)showTabbarView;

@end

