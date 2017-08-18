//
//  WaterModel.m
//  YiAi
//
//  Created by zlkj on 2017/6/30.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "WaterModel.h"

@implementation WaterModel



+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"projectId":@"ID",
             @"devType":@"devType",
             @"projectName":@"projectName",
             @"time":@"time",
             @"dataValue":@"dataValue",
             @"status":@"status",
             @"note":@"note"
             
             };
}

@end
