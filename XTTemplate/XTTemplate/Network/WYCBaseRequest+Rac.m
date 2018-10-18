//
//  WYCBaseRequest+Rac.m
//  WYC_iOS
//
//  Created by Admin on 2018/7/5.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCBaseRequest+Rac.h"
#import "NSObject+RACDescription.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import "MBProgressHUD+XTExtension.h"

@implementation WYCBaseRequest (Rac)

- (RACSignal *)rac_requestSignalWithShowHud:(BOOL)isShowLoad LoadingMsg:(NSString *)loadMsg successMsg:(NSString *)successMsg{
    
    [self stop];
    @weakify(self);
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        @strongify(self);
        
//        networkActivityIndicatorVisible
        
        // 增加提示框
        if (isShowLoad){
            [MBProgressHUD showLoadingMessage:loadMsg];
        }
        
        [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            // 移除提示框
            if (isShowLoad){
                [MBProgressHUD hideHUD];
            }
            
            
            NSLog(@"%@",request.currentRequest.URL);
            id results = [request responseJSONObject];
            
            if (results && ![results isKindOfClass:[NSDictionary class]]){
                [subscriber sendNext:results];
                [subscriber sendCompleted];
                return;
            }
            
            NSString *code = [self DecodeStringFromDic:results codeKey:CRM_BaseRequest_StatusCodeKey];
            
            if ([code isEqualToString:CRM_BaseRequest_DataValueKey]) {
                
                if (successMsg){
                    [MBProgressHUD showSuccessfulMsg:successMsg toView:[UIApplication sharedApplication].keyWindow];
                }
                
                // 请求成功
                
                // 如果有过滤器，这里可以调用过滤器
                id data = [results objectForKey:CRM_BaseRequest_DataKey];
                
//                data = kObjectIsEmpty(data)?nil:data;
                
                [subscriber sendNext:data];
                [subscriber sendCompleted];
                
            }else{
                
                // 请求失败
                id errorMsg = [results objectForKey:CRM_BaseRequest_StatusMsgKey];
                if (!errorMsg) errorMsg = @"未知错误";
                
                [MBProgressHUD showErrorMsg:errorMsg toView:[UIApplication sharedApplication].keyWindow];
                
                [subscriber sendError:[NSError errorWithDomain:errorMsg code:CRM_ERRORCODE userInfo:@{NSLocalizedDescriptionKey:@"Invalid Request Code"}]];
                [subscriber sendCompleted];
                
                if([code isEqualToString:CRM_BaseRequest_NotLoginValueKey]){
                    
                    
                }
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            
            [MBProgressHUD showErrorMsg:@"网络似乎除了点问题!" toView:[UIApplication sharedApplication].keyWindow];
            
            
            [subscriber sendError:[request error]];
            [subscriber sendCompleted];
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            @strongify(self);
            
            if (!self.isCancelled){
                [self stop];
            }
        }];
    }] takeUntil:self.rac_willDeallocSignal];
    
//    if (DEBUG) {
//        [signal setNameWithFormat:@"%@ -rac_WYCRequest",  RACDescription(self)];
//    }
    
    return signal;
}

- (RACSignal *)rac_requestSignal{
    
    return [self rac_requestSignalWithShowHud:NO LoadingMsg:nil successMsg:nil];
}

- (RACSignal *)rac_requestSignalShowLoading{
    
    return [self rac_requestSignalWithShowHud:YES LoadingMsg:nil successMsg:nil];
}

- (RACSignal *)rac_requestSignalShowLoadingWithMsg:(NSString *)loadingMsg{
    
    return [self rac_requestSignalWithShowHud:YES LoadingMsg:loadingMsg successMsg:nil];
}

- (RACSignal *)rac_requestSignalShowLoadingWithMsg:(NSString *)loadingMsg withSuccessMsg:(NSString *)successMsg{
    
    return [self rac_requestSignalWithShowHud:YES LoadingMsg:loadingMsg successMsg:successMsg];
    
}
@end
