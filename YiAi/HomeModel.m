//
//  HomeModel.m
//  YiAi
//
//  Created by zlkj on 2017/6/21.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"proCode":@"proCode",
             @"projectFireName":@"projectFireName",
             @"projectImg":@"projectImg",
             @"projectName":@"projectName",
             @"projectProtectName":@"projectProtectName",
             @"projectStore":@"projectStore",
             @"projectType":@"projectType"
             
             };
}

@end
