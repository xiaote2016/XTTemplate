//
//  MBProgressHUD+XTExtension.m
//  WYC_iOS
//
//  Created by xiete@wyc.cn on 2018/7/3.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "MBProgressHUD+XTExtension.h"
#import <Lottie/LOTAnimationView.h>

@implementation MBProgressHUD (XTExtension)

- (void)interaction{
    self.userInteractionEnabled = NO;
}

#pragma mark - loadingShow
+ (MBProgressHUD *)showLoading{
    
    return [self showLoadingMessage:nil toView:nil];
}

+ (MBProgressHUD *)showLoadingToView:(nullable UIView *)view{
    
    return [self showLoadingMessage:nil toView:view];
}

+ (MBProgressHUD *)showLoadingMessage:(nullable NSString *)message{
    
    return [self showLoadingMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoadingMessage:(nullable NSString *)message toView:(nullable UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    if ([view.subviews.lastObject isKindOfClass:[MBProgressHUD class]]){
        return nil;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.opacity = 0.5;
    
    hud.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
//    hud.userInteractionEnabled = NO;
    
    [[self shareLoading] play];
    
    hud.customView = [self shareLoading];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    if (message){
        hud.labelText = message;
    }
    hud.removeFromSuperViewOnHide = YES;
    
    hud.yOffset = -50;
    
    return hud;
}

#pragma mark - successful

+ (void)showSuccess{
    [self showSuccessfulMsg:nil toView:nil];
}

+ (void)showSuccessfulMsg:(nullable NSString *)message toView:(nullable UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.opacity = 0.8;
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"successAnimation"];
    animation.frame = CGRectMake(0, 0, 40, 40);
    [animation playWithCompletion:^(BOOL animationFinished) {
        [animation removeFromSuperview];
    }];
    
    hud.customView = animation;
    
    hud.yOffset = -50;
    hud.mode = MBProgressHUDModeCustomView;
    
    if (message){
        hud.labelText = message;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:animation.animationDuration];
}

#pragma mark - error

+ (void)showError{
    [self showErrorMsg:nil toView:nil];
}

+ (void)showErrorMsg:(nullable NSString *)message  toView:(nullable UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.opacity = 0.8;
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"errorAnimation"];
    animation.frame = CGRectMake(0, 0, 40, 40);
    [animation playWithCompletion:^(BOOL animationFinished) {
        [animation removeFromSuperview];
    }];
    
    hud.customView = animation;
    hud.yOffset = -50;
    hud.mode = MBProgressHUDModeCustomView;
    
    if (message){
        hud.labelText = message;
    }
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:animation.animationDuration];
}

#pragma mark - toast
+ (void)showText:(NSString *)text{
    
    [self showText:text View:nil];
}

+ (void)showText:(NSString *)text View:(nullable UIView *)view{
    
    [self showPlainText:text hideAfterDelay:2.0 view:view];
}

+ (void)showPlainText:(NSString *)text
          hideAfterDelay:(NSTimeInterval)time
                    view:(nullable UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 2秒之后再消失
    [hud hide:YES afterDelay:time];
    
}

#pragma mark - lot动画
static LOTAnimationView *shareLoading = nil;
+ (LOTAnimationView *)shareLoading{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareLoading = [LOTAnimationView animationNamed:@"animation-w180-h180"];
        shareLoading.loopAnimation = YES;
        shareLoading.frame = CGRectMake(0, 0, 40, 40);
    });
    
    return shareLoading;
}


#pragma mark - hide
+ (void)hideHUDForView:(nullable UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    [self hideHUDForView:view animated:YES];
    
    [[self shareLoading] pause];
}

+ (void)hideHUD{
    
    [self hideHUDForView:nil];
}

@end
