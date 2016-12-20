//
//  CustomTableView.h
//  TableViewCategory
//
//  Created by HuDaQian on 2016/12/19.
//  Copyright © 2016年 HuXiaoQian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceHolderView.h"


typedef void(^RefreshDataBlock)(void);
@interface CustomTableView : UITableView

@property (nonatomic, retain) CustomPlaceHolderView *placeHolderView;

@property (nonatomic, copy) RefreshDataBlock freshBlock;

@end
