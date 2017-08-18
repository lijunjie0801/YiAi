//
//  XFModel.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "XFModel.h"

@implementation XFModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"alarmTime":@"alarmTime",
             @"basePosition":@"basePosition",
             @"controlId":@"controlId",
             @"controlTypeGet":@"controlTypeGet",
             @"hostId":@"hostId",
             @"localPosition":@"localPosition"
             
             };
}
@end
