//
//  FireModel.h
//  YiAi
//
//  Created by zlkj on 2017/6/22.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface FireModel : BaseModel

@property(nonatomic, strong) NSString *projectId; //id
@property(nonatomic, strong) NSString *address; //地址
@property(nonatomic, strong) NSString *projectName; //名字
@property(nonatomic, strong) NSString *time; //时间
@property(nonatomic, strong) NSString *alarmModule; //方位
@property(nonatomic, strong) NSString *alarmContent; //项目类型

@end
