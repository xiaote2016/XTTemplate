//
//  BaseTableViewBindingHelper.m
//  XTTemplate
//
//  Created by xiete@wyc.cn on 2018/10/17.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "BaseTableViewBindingHelper.h"
#import "ViewProtocol.h"
#import <UIScrollView+EmptyDataSet.h>

NSString *const DataIndexPath = @"DataIndexPath";

@implementation BaseTableViewHelperConfig
- (instancetype)initWithTemplateCell:(NSString *)templateCell isSections:(BOOL)isSections{
    if (self = [super init]){
        
        _templateCell = templateCell;
        _isSections = isSections;
        
    }
    return self;
}
- (NSString *)templateCell{
    if (!_templateCell){
        _templateCell = @"cell";
    }
    return _templateCell;
}
@end


@interface BaseTableViewBindingHelper()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *datas;

@property (nonatomic, strong) RACCommand *didSelectionCommand;

@property (nonatomic, strong) BaseViewModel *viewModel;

@property (nonatomic, strong) BaseTableViewHelperConfig *config;

@end

@implementation BaseTableViewBindingHelper

- (instancetype)initWithHelperForTableView:(UITableView *)tableView datasSignal:(RACSignal *)datasSignal selectionCommand:(RACCommand *)didSelectionCommand viewModel:(BaseViewModel *)viewModel withConfig:(BaseTableViewHelperConfig *)config{
    if (self = [super init]){
        
        _tableView = tableView;
        _datas = [NSArray array];
        _didSelectionCommand = didSelectionCommand;
        _viewModel = viewModel;
        _config = config;
    
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        // 注册cell
        if(!_config.isXibCell){
            
            [_tableView registerClass:NSClassFromString(_config.templateCell) forCellReuseIdentifier:_config.templateCell];
            
        }else{
            
            [_tableView registerNib:[UINib nibWithNibName:_config.templateCell bundle:nil] forCellReuseIdentifier:_config.templateCell];
        }
        
        
        @weakify(self);
        [datasSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.datas = x;
            [self.tableView reloadData];
        }];
    }
    return self;
}

- (void)dealloc{
    
    self.delegate = nil;
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!self.config.isSections){
        
        return 1;
    }else{
        
        return self.datas.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!self.config.isSections){
        
        return self.datas.count;
    }else{
        
        id item = self.datas[section];
        
        if ([item isKindOfClass:[NSArray class]]){
            
            return ((NSArray *)item).count;
        }else{
            
            return 1;
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell<ViewProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:self.config.templateCell forIndexPath:indexPath];
    
    [cell bindViewModel:self.viewModel withParams:@{DataIndexPath : indexPath}];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.didSelectionCommand execute:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
        
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]){
        
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return 44;
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    
    NSString *text;
//    if (self.viewModel.netWorkStatus == RealStatusNotReachable) {
//
//        text = @"网络君失联了,请检查你的网络设置!";
//    }else{
        text = @"此页面可能去火星旅游了!";
//    }
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    UIColor *textColor = [UIColor grayColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return (self.datas.count == 0) ? YES : NO;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}



- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
