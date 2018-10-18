//
//  ViewController.m
//  XTTemplate
//
//  Created by xiete@wyc.cn on 2018/10/17.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "ViewController.h"
#import "CTMediator+DeviceModule.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)test:(id)sender {
    
    UIViewController *vc = [[CTMediator sharedInstance] CTMediator_DeviceController];
    
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
