//
//  BreakModel.h
//  YiAi
//
//  Created by lijunjie on 2017/7/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BreakModel : NSObject
@property(nonatomic, strong) NSString *projectId; //id
@property(nonatomic, strong) NSString *address; //地址
@property(nonatomic, strong) NSString *projectName; //名字
@property(nonatomic, strong) NSString *time; //时间
@property(nonatomic, strong) NSString *alarmModule; //方位
@property(nonatomic, strong) NSString *alarmContent; //项目类型
@end
