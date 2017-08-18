//
//  XFListModel.m
//  YiAi
//
//  Created by lijunjie on 2017/8/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "XFListModel.h"

@implementation XFListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"hostId":@"hostId",
             @"portAddressList":@"portAddressList",
             };
}
@end
