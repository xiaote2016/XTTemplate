//
//  CRMBaseViewController.m
//  WYC_CRM
//
//  Created by xiete@wyc.cn on 2018/8/9.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButton+HitRect.h"
#import "BaseViewModel.h"

#define IOS11_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite)BaseViewModel *viewModel;

@end

@implementation BaseViewController{
    id<UIGestureRecognizerDelegate> _gestureRecognizerDelegate;
}

- (void)dealloc{
    
    NSLog(@"%@---销毁了",[self class]);
}

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel{
    if (self = [super init]){
        
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBackButton];
    
    [self setupUI];
    
    [self initialDefaultsForController];
    
    [self bindViewModelForController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.navigationController.viewControllers.count > 1){
        if (![self.navigationController.interactivePopGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_UINavigationInteractiveTransition")]){
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        if (!_gestureRecognizerDelegate || ![_gestureRecognizerDelegate isKindOfClass:NSClassFromString(@"_UINavigationInteractiveTransition")]){
            _gestureRecognizerDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        }
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    if (_gestureRecognizerDelegate){
        
        self.navigationController.interactivePopGestureRecognizer.delegate = _gestureRecognizerDelegate;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)setupUI{
    
}

- (void)initialDefaultsForController{
    
}

- (void)bindViewModelForController{
    
}

- (void)setupBackButton{
    // 自定义返回按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setImage:[[UIImage imageNamed:@"backicon_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];;
    //创建UIBarButtonSystemItemFixedSpace
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = IOS11_OR_LATER ? 0 : -15;
    if (IOS11_OR_LATER) {
        button.contentEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
        button.imageEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
        button.hitEdgeInsets =UIEdgeInsetsMake(0, -6, 0, 0);
    }
    //将两个BarButtonItem都返回给NavigationItem
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftBarBtn];
}

- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
