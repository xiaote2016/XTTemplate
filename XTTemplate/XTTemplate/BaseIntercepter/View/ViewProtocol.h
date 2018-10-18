//
//  ViewProtocol.h
//  XTTemplate
//
//  Created by xiete@wyc.cn on 2018/10/17.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ViewProtocol <NSObject>

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
