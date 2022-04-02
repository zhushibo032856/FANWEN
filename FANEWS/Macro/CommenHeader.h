//
//  CommenHeader.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#ifndef CommenHeader_h
#define CommenHeader_h

/** Estimate Is Null */
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 || [str isEqualToString:@""]||[str isEqualToString:@"null"] ? YES : NO )
#define kArrayIsEmpty(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) ? YES : NO)
#define kDictIsEmpty(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0) ? YES : NO)
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


/** Screen Size */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


#define iPhoneX ((kScreenWidth >= 375 && kScreenHeight >= 812) ? YES : NO)
#define kCurrentDevice [[[UIDevice currentDevice] systemVersion] floatValue]
#define isPhone ((UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? YES : NO)

/** Scale Width / Height */
#define KCommen 86 + 59
#define kNav_H kScreenHeight > 668 ? 86 : 64
#define kTabbar_H (iPhoneX ? 81 : 49)
#define ScaleNumberWidth kScreenWidth / 375
#define ScaleNumberHeight  (iPhoneX ? kScreenHeight / 812 :  kScreenHeight / 667)
#define kNavHeight  (iPhoneX ? 88 : 64)
#define kSNavHeight (iPhoneX ? 22 : 0)
#define kSVerticalHeight(n) (iPhoneX ? 22 + 145 / n : 0)
/** Setting Color */
#define CRColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


/** RGB Color Value Settings */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/** Set The Random Color */
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/** NSlog */
#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif


/** Common Font */
#define FontType_Text(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define FontType_Title(s) [UIFont fontWithName:@"PingFangHK-Regular" size:s]
#define FontType_Bold(s) [UIFont fontWithName:@"PingFangSC-Semibold" size:s]

#define KUIFont(fontSize) [UIFont systemFontOfSize:fontSize]  ///最最普通的系统默认字体
#define KUIFont_bold(fontSize) [UIFont boldSystemFontOfSize:fontSize]

/** Weak References / Strong References */
#define kWeakSelf __weak typeof(self) weakSelf = self;
#define kStrongSelf(type)  __strong typeof(type) type = weak##type;

/** Some Abbreviations */
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate

/** UserDefaults */
#define kUserDefaults       [NSUserDefaults standardUserDefaults]

#define KTITLEARR           [kUserDefaults valueForKey:@"TITLEARR"]

#define KXIBVIEW(name)  return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];


/** App Version */
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/** NSNotification*/

#define KCellBeganEditing  @"notification_CellBeganEditing"
#define KCellStateChange   @"notification_CellStateChange"

#endif /* CommenHeader_h */
