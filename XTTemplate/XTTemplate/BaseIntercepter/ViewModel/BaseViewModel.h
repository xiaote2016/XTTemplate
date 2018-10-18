//
//  BaseViewModel.h
//  XTTemplate
//
//  Created by xiete@wyc.cn on 2018/10/17.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC/ReactiveObjC.h"
#import "ViewModelService.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject


@property (nonatomic, strong, readonly) RACCommand *requestDatasCommand;

@property (nonatomic, strong, readonly) id<ViewModelService> services;


- (instancetype)initWithParams:(NSDictionary *)params;

- (instancetype)initWithServices:(nullable id<ViewModelService>)services params:(NSDictionary *)params;

- (void)initializeForViewModel;
@end

NS_ASSUME_NONNULL_END
