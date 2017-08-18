//
//  BreakModel.m
//  YiAi
//
//  Created by lijunjie on 2017/7/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BreakModel.h"

@implementation BreakModel


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"projectId":@"ID",
             @"address":@"address",
             @"projectName":@"projectName",
             @"time":@"time",
             @"alarmModule":@"alarmModule",
             @"alarmContent":@"alarmContent"
             
             };
}
@end
