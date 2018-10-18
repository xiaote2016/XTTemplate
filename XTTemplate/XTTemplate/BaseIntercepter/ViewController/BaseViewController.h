//
//  CRMBaseViewController.h
//  WYC_CRM
//
//  Created by xiete@wyc.cn on 2018/8/9.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewModel;
@interface BaseViewController : UIViewController

@property (nonatomic, strong, readonly) BaseViewModel *viewModel;

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;

/// 初始化UI
- (void)setupUI;

/// 初始化数据
- (void)initialDefaultsForController;

/// 绑定VM
- (void)bindViewModelForController;
@end
