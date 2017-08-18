//
//  WaterModel.h
//  YiAi
//
//  Created by zlkj on 2017/6/30.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface WaterModel : BaseModel


@property(nonatomic, strong) NSString *projectId; //id
@property(nonatomic, strong) NSString *projectName; //名字
@property(nonatomic, strong) NSString *devType; //内容
@property(nonatomic, strong) NSString *dataValue; //内容值
@property(nonatomic, strong) NSString *time; //时间
@property(nonatomic, strong) NSString *status; //项目类型
@property(nonatomic, strong) NSString *note; //地址

@end
