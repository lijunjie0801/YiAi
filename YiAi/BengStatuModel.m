//
//  BengStatuModel.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BengStatuModel.h"

@implementation BengStatuModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"status":@"status",
             @"localPosition":@"localPosition",
             @"note":@"note",
             @"time":@"time",
             };
}
@end
