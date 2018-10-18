//
//  WYCBaseRequest.m
//  WYC_iOS
//
//  Created by Admin on 2018/7/4.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCBaseRequest.h"
#import <objc/runtime.h>

// 获取服务器响应状态码 key
NSString * const CRM_BaseRequest_StatusCodeKey = @"code";
// 服务器响应数据成功状态码 value
NSString * const CRM_BaseRequest_DataValueKey = @"00";
// 未登录
NSString * const CRM_BaseRequest_NotLoginValueKey = @"203";
// 获取服务器响应状态信息 key
NSString * const CRM_BaseRequest_StatusMsgKey = @"msg";
// 获取服务器响应数据 key
NSString * const CRM_BaseRequest_DataKey = @"data";

//#define DEBUG_PRODUCTION_BASEURL 1

#ifdef DEBUG_PRODUCTION_BASEURL
NSString * const REG_URL=@"http://10.252.244.183:8084/"; // 10.252.244.183:8084
NSString * const KprivacyUrl = @"http://10.252.244.183:8084/prep/privacy";
NSString * const KUserAgentUrl = @"http://10.252.244.183:8084/prep/user-agreement";
#else
NSString * const REG_URL=@"https://crm.wyc.cn/"; //
NSString * const KprivacyUrl = @"https://crm.wyc.cn/prep/privacy";
NSString * const KUserAgentUrl = @"https://crm.wyc.cn/prep/user-agreement";
#endif

@interface WYCBaseRequest ()

@end

@implementation WYCBaseRequest


- (instancetype)init{
    if (self = [super init]){
        
//        [RACObserve(self, isExecuting) subscribeNext:^(id  _Nullable x) {
//            
//        }];
    }
    return self;
}

+ (NSArray *)mj_allowedPropertyNames{
    
    NSMutableArray *kArray = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        
        
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        [kArray addObject:name];
        
    }
    free(properties);
    return kArray;
}

- (NSString *)baseUrl{
    return REG_URL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}

/// 请求参数
- (id)requestArgument
{
    NSMutableDictionary *param = [self wyc_requestParameters].mutableCopy;
    
    return param;
}

- (nullable NSDictionary *)wyc_requestParameters;{
    
    return nil;
}

/// 超时时间
- (NSTimeInterval)requestTimeoutInterval
{
    return 20.f;
}

//- (id)responseJSONObject{
//    id results = [super responseJSONObject];
//    id data = [results objectForKey:CRM_BaseRequest_DataKey];
//    return data;
//}

//- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary{
//    NSString *version = App_Version;
//    NSMutableDictionary *reqHeaderDic = @{@"User-Agent":@"ios",@"version":version}.mutableCopy;
//    return reqHeaderDic;
//}

- (NSString *)DecodeStringFromDic:(NSDictionary *)dic codeKey:(NSString *)key{
    if (!dic)
    {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        if ([temp isEqualToString:@"(null)"]) {
            return @"";
        }
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

@end
