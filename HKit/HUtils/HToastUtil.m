//
//  HToastUtil.m
//  DZNEmptyDataSet
//
//  Created by Salvador on 2020/1/4.
//

#import "HToastUtil.h"
#import "MBProgressHUD.h"
#import "UIMacro.h"

@implementation HToastUtil

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
    [hud hideAnimated:YES afterDelay:2];
}

@end
