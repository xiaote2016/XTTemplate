//
//  Target_Device.m
//  XT_ Intelligent
//
//  Created by 小特 on 2018/5/31.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "Target_Device.h"
#import "ModuleOneViewController.h"

@implementation Target_Device

- (UIViewController *)Action_DeviceVC:(NSDictionary *)params{
    ModuleOneViewController *deviceVC = [[ModuleOneViewController alloc] init];
    
    if (params && params[@"title"]){
        deviceVC.title = params[@"title"];
    }
    
    return deviceVC;
}
@end
