//
//  NFCModel.m
//  YiAi
//
//  Created by lijunjie on 2017/7/19.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "NFCModel.h"

@implementation NFCModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"nfcPatrolPerson":@"nfcPatrolPerson",
             @"nfcPatrolTime":@"nfcPatrolTime",
             @"nfcRemark":@"nfcRemark",
             @"nfcStatus":@"nfcStatus",
             @"DomainUrl":@"DomainUrl",
             @"nfcFarImg":@"nfcFarImg",
             @"nfcNearImg":@"nfcNearImg",
             @"nfcDetailImg":@"nfcDetailImg"
             
             };
}
@end
