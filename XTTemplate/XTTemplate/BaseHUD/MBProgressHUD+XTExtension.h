//
//  MBProgressHUD+XTExtension.h
//  WYC_iOS
//
//  Created by xiete@wyc.cn on 2018/7/3.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XTExtension)

/**
    允许交互 默认是不允许交互
 */
- (void)interaction;

#pragma mark - loadingShow

/**
 显示正在加载的视图
 */
+ (MBProgressHUD *)showLoading;


/**
 显示正在加载的视图

 @param view hud将要显示的父视图
 */
+ (MBProgressHUD *)showLoadingToView:(nullable UIView *)view;


/**
 显示带文字的正在加载的视图

 @param message 显示的文字
 */
+ (MBProgressHUD *)showLoadingMessage:(nullable NSString *)message;


/**
 显示带文字的正在加载的视图

 @param message 显示的文字
 @param view hud将要显示的父视图
 */
+ (MBProgressHUD *)showLoadingMessage:(nullable NSString *)message toView:(nullable UIView *)view;


/**
 成功显示
 */
+ (void)showSuccess;

/**
 成功显示

 @param message 成功显示的文字
 @param view 父视图
 */
+ (void)showSuccessfulMsg:(nullable NSString *)message toView:(nullable UIView *)view;

/**
 失败显示
 */
+ (void)showError;

/**
 失败显示

 @param message 失败显示的文字
 @param view 父视图
 */
+ (void)showErrorMsg:(nullable NSString *)message  toView:(nullable UIView *)view;

#pragma mark - toast


/**
 Toast
 */
+ (void)showText:(NSString *)text;

/**
 Toast

 @param text 显示的文本
 @param view 显示的父视图
 */
+ (void)showText:(NSString *)text View:(nullable UIView *)view;

#pragma mark - hideHUD

/**
 隐藏HUD
 */
+ (void)hideHUD;

/**
 隐藏HUD
 */
+ (void)hideHUDForView:(nullable UIView *)view;
@end
