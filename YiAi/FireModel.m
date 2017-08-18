//
//  FireModel.m
//  YiAi
//
//  Created by zlkj on 2017/6/22.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "FireModel.h"

@implementation FireModel



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
