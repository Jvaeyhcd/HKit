//
//  HToastUtil.m
//  DZNEmptyDataSet
//
//  Created by Salvador on 2020/1/4.
//

#import "HHUDUtil.h"
#import "MBProgressHUD.h"
#import "UIMacro.h"

@implementation HHUDUtil

/**
 *  显示提示消息
 */
+ (void)showToast:(NSString *)msg{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.margin = 10.f;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

+ (void)showLoading {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
}

+ (void)hideLoading {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
