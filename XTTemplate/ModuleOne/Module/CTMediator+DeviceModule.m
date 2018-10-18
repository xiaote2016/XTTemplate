//
//  CTMediator+DeviceModule.m
//  XT_ Intelligent
//
//  Created by 小特 on 2018/5/31.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "CTMediator+DeviceModule.h"

NSString * const kCTMediatorTargetDevice = @"Device";

NSString *const kCTMediatorActionDeviceVC = @"DeviceVC";

@implementation CTMediator (DeviceModule)
- (UIViewController *)CTMediator_DeviceController{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetDevice
                                                    action:kCTMediatorActionDeviceVC
                                                    params:@{@"title":@"设备"}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}
@end
