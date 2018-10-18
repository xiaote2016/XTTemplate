//
//  WYCBaseRequest+Rac.h
//  WYC_iOS
//
//  Created by Admin on 2018/7/5.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCBaseRequest.h"


@class RACSignal;
@interface WYCBaseRequest (Rac)


/**
 无提示框

 @return 网络请求信号
 */
- (RACSignal *)rac_requestSignal;

/**
 有提示框

 @return 网络请求信号
 */
- (RACSignal *)rac_requestSignalShowLoading;

/**
 有提示框

 @param loadingMsg 提示框显示文字
 @return 网络请求信号
 */
- (RACSignal *)rac_requestSignalShowLoadingWithMsg:(NSString *)loadingMsg;

/**
 提示框加成功提示

 @param loadingMsg 提示框显示文字
 @param successMsg 成功提示
 @return 网络请求信号
 */
- (RACSignal *)rac_requestSignalShowLoadingWithMsg:(NSString *)loadingMsg withSuccessMsg:(NSString *)successMsg;
@end
