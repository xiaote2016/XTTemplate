//
//  WYCBaseRequest.h
//  WYC_iOS
//
//  Created by Admin on 2018/7/4.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "YTKRequest.h"

#define CRM_ERRORCODE -1

// 获取服务器响应状态码 key
extern NSString * _Nullable const CRM_BaseRequest_StatusCodeKey;
// 服务器响应数据成功状态码 value
extern NSString * _Nullable const CRM_BaseRequest_DataValueKey;
// 未登录
extern NSString * _Nullable const CRM_BaseRequest_NotLoginValueKey;
// 获取服务器响应状态信息 key
extern NSString * _Nullable const CRM_BaseRequest_StatusMsgKey;
// 获取服务器响应数据 key
extern NSString * _Nonnull const CRM_BaseRequest_DataKey;
//隐私政策
extern NSString * _Nonnull const KprivacyUrl;

extern NSString * _Nonnull const KUserAgentUrl;

@interface WYCBaseRequest : YTKRequest

/// 需要请求参数统一加密处理的重写这个方法返回请求参数
- (nullable NSDictionary *)wyc_requestParameters;


- (NSString *_Nullable)DecodeStringFromDic:(NSDictionary *_Nullable)dic codeKey:(NSString *_Nullable)key;
@end
