//
//  DeviceModel.h
//  YiAi
//
//  Created by lijunjie on 2017/7/27.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject
@property(nonatomic, strong) NSString *deviceId;
@property(nonatomic, strong) NSString *localPosition;
@property(nonatomic, strong) NSString *note;
@property(nonatomic, strong) NSString *voltageValue;
@property(nonatomic, strong) NSString *thresholdUpLimit;
@property(nonatomic, strong) NSString *thresholdDownLimit;
@end
