//
//  HomeModel.h
//  YiAi
//
//  Created by zlkj on 2017/6/21.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel
@property(nonatomic, strong) NSString *proCode; //id
@property(nonatomic, strong) NSString *projectFireName; //地址
@property(nonatomic, strong) NSString *projectImg; //图片
@property(nonatomic, strong) NSString *projectName; //哪个楼房
@property(nonatomic, strong) NSString *projectProtectName; //项目名称
@property(nonatomic, strong) NSString *projectStore; //得分
@property(nonatomic, strong) NSString *projectType; //项目类型


@end
