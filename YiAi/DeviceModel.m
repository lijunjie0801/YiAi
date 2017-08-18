//
//  DeviceModel.m
//  YiAi
//
//  Created by lijunjie on 2017/7/27.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"deviceId":@"deviceId",
             @"localPosition":@"localPosition",
             @"note":@"note",
             @"voltageValue":@"voltageValue",
             @"thresholdUpLimit":@"thresholdUpLimit",
             @"thresholdDownLimit":@"thresholdDownLimit",
             };
}
@end
