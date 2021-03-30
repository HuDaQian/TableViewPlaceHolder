//
//  CustomTableView+PlaceHolderView.m
//  TableViewCategory
//
//  Created by HuDaQian on 2016/12/19.
//  Copyright © 2016年 HuXiaoQian. All rights reserved.
//

#import "CustomTableView+PlaceHolderView.h"
#import "ConnectManager.h"

#import <objc/runtime.h>

@implementation CustomTableView (PlaceHolderView)
- (void)checkEmpty {
    BOOL isEmpty = YES;
    
    id  dataSource = self.dataSource;
    NSInteger sections;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前TableView组数
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        //获取当前TableView各组行数
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    if (isEmpty) {
        //根据网络状态 显示不同的占位图
        [self makeDefaultPlaceholderView];
    } else {
        //不为空，隐藏占位图
        self.placeHolderView.hidden = YES;
    }
}

- (void)makeDefaultPlaceholderView {
    if (!self.placeHolderView) {
        //根据自己的需要选择不同的frame
        CGRect frameNOHeader = CGRectMake(self.frame.origin.x, self.tableHeaderView.frame.size.height, self.frame.size.width, self.frame.size.height-self.tableHeaderView.frame.size.height);
        CGRect frameNOHeaderFooter = CGRectMake(self.frame.origin.x, self.tableHeaderView.bounds.size.height, self.frame.size.width, self.tableFooterView.frame.origin.y-self.tableHeaderView.frame.size.height);
        CGRect frameAll = self.bounds;
        
        self.placeHolderView = [[CustomPlaceHolderView alloc] initWithFrame:frameAll];
        [self addSubview:self.placeHolderView];
    }
    //判读网络状态 显示不同的占位图
    BOOL connectStatus = [ConnectManager isExistenceNetwork];
    [self.placeHolderView setPlaceHolderDataWithStatus:connectStatus];
    self.placeHolderView.hidden = NO;
    //增加手势 没有网络的情况也需要增加手势
//    if (connectStatus) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
        [self.placeHolderView addGestureRecognizer:tapGes];
//    } else {
//        for (UIGestureRecognizer *ges in self.placeHolderView.gestureRecognizers) {
//            [self.placeHolderView removeGestureRecognizer:ges];
//        }
//    }
}

- (void)tapHandle {
    self.freshBlock();
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //方法交换，将reloadData实现交换为sure_reloadData
        Method methodOne = class_getInstanceMethod(self, @selector(reloadData));
        Method methodTwo = class_getInstanceMethod(self, @selector(sure_reloadData));
        //交换两个方法的实现
        method_exchangeImplementations(methodOne, methodTwo);
    });
}

- (void)sure_reloadData {
    [self checkEmpty];
    [self sure_reloadData];
}

-(void)reloadData {
    
}

@end
