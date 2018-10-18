//
//  BaseTableViewBindingHelper.h
//  XTTemplate
//
//  Created by xiete@wyc.cn on 2018/10/17.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC/ReactiveObjC.h"
#import "BaseViewModel.h"

FOUNDATION_EXTERN NSString * _Nonnull const DataIndexPath;

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewHelperConfig : NSObject

/**
 数据是否分组显示
 */
@property (nonatomic, assign) BOOL isSections;

/**
 是否用xib创建cell
 */
@property (nonatomic, assign) BOOL isXibCell;

/**
 celle的类名
 */
@property (nonatomic, copy) NSString *templateCell;

- (instancetype)initWithTemplateCell:(NSString *)templateCell isSections:(BOOL)isSections;

@end

@interface BaseTableViewBindingHelper : NSObject

@property (nonatomic, weak) id<UITableViewDelegate> delegate;

/**
 配置tableView

 @param tableView tableView
 @param datasSignal 数据信号
 @param didSelectionCommand 选中cell的信号
 @param viewModel viewModel
 @param config 配置
 @return self
 */
- (instancetype)initWithHelperForTableView:(UITableView *)tableView datasSignal:(RACSignal *)datasSignal selectionCommand:(RACCommand *)didSelectionCommand viewModel:(BaseViewModel *)viewModel withConfig:(BaseTableViewHelperConfig *)config;


@end

NS_ASSUME_NONNULL_END
