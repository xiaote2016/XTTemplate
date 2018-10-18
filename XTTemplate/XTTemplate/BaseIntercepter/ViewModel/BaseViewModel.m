//
//  BaseViewModel.m
//  XTTemplate
//
//  Created by xiete@wyc.cn on 2018/10/17.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel ()


@property (nonatomic, strong, readwrite) RACCommand *requestDatasCommand;

@property (nonatomic, strong, readwrite) id<ViewModelService> services;


@end

@implementation BaseViewModel

- (instancetype)initWithParams:(NSDictionary *)params{
    
    return [self initWithServices:nil params:params];
}

- (instancetype)initWithServices:(nullable id<ViewModelService>)services params:(NSDictionary *)params{
    
    if (self = [super init]){
        
        self.services = services;
        
        @weakify(self);
        self.requestDatasCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            
            return [[self executeRequestDataSignal:input] takeUntil:self.rac_willDeallocSignal];
            
        }];
    }
    return self;
}

- (void)initializeForViewModel{
    
}

- (RACSignal *)executeRequestDataSignal:(id)input{
    
    return [RACSignal empty];
}
@end
