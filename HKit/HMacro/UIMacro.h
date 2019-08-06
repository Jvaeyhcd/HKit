//
//  UIMacro.h
//  Flower
//
//  Created by 超讯研发部 on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

#define STATUS_BAR_HEIGHT       ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATION_BAR_HEIGHT   ([HRouter topNavigationController].navigationBar.frame.size.height)
#define STATUS_NAV_HEIGHT       (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define TAB_BAR_HEIGHT          ([HRouter rootTabBarController].tabBar.frame.size.height)

#define SAFE_BOTTOM_MARGIN      (IS_IPHONE_X ? 34.f : 0.f)

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)

// 默认间距
#define DEFAULT_SPACE           kScaleFromDesign(16.0)
// 比默认间距小一点的间距
#define SMALL_SPACE             kScaleFromDesign(10.0)

// 各种iPhone屏幕的尺寸
#define IPHONE_3_5_WIDTH        320
#define IPHONE_3_5_HEIGHT       480
#define IPHONE_4_0_WIDTH        320
#define IPHONE_4_0_HEIGHT       568
#define IPHONE_4_7_WIDTH        375
#define IPHONE_4_7_HEIGHT       667
#define IPHONE_5_5_WIDTH        414
#define IPHONE_5_5_HEIGHT       736
#define IPHONE_5_8_WIDTH        375
#define IPHONE_5_8_HEIGHT       812
#define IPHONE_6_5_WIDTH        414
#define IPHONE_6_5_HEIGHT       896

// 判断当前设备的尺寸
#define IS_IPHONE_3_5           ((SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_3_5_HEIGHT)
#define IS_IPHONE_4_0           ((SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_4_0_HEIGHT)
#define IS_IPHONE_4_7           ((SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_4_7_HEIGHT)
#define IS_IPHONE_5_5           ((SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_5_5_HEIGHT)
#define IS_IPHONE_5_8           ((SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_5_8_HEIGHT)
#define IS_IPHONE_6_5           ((SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_6_5_HEIGHT)

#define IS_IPHONE_X             (IS_IPHONE_5_8 || IS_IPHONE_6_5)

#pragma mark - 颜色
/**
 *  颜色相关
 */
#define Color(r,g,b,a)          ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
//APP背景颜色
#define APP_BG_COLOR            Color(245, 245, 245, 1)
//APP主题色
#define APP_THEME_COLOR         Color(91, 162, 243, 1)
//WebView加载条颜色
#define WEB_LOADING_COLOR       Color(255, 189, 44, 1)

//TabBar主题色
#define TAB_BAR_TINT_COLOR      Color(248, 248, 255, 1)
#define TAB_BAR_SELECTED_COLOR  Color(18, 150, 219, 1)
#define TAB_BAR_UNSELECT_COLOR  Color(230, 230, 230, 1)

#define kScaleFromDesign(x)     (x * (SCREEN_WIDTH / IPHONE_4_7_WIDTH))

#endif /* UIMacro_h */
