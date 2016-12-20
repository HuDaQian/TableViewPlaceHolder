//
//  ConnectManager.m
//  TableViewCategory
//
//  Created by HuDaQian on 2016/12/19.
//  Copyright © 2016年 HuXiaoQian. All rights reserved.
//

#import "ConnectManager.h"

#import "Reachability.h"

@implementation ConnectManager

+ (BOOL)isExistenceNetwork {
    BOOL isExistenceNetwork;
    //著名测速网站
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch([reachability currentReachabilityStatus]){
        case NotReachable: isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN: isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi: isExistenceNetwork = TRUE;
            break;
    }
    return isExistenceNetwork;
}

@end
