//
//  BaseModel.h
//  YiAi
//
//  Created by zlkj on 2017/6/21.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessHandle)(id object);
typedef void (^FailedCompletionHander)(NSError *error,NSUInteger statusCode);
@interface BaseModel : NSObject

/**
 *  返回解析完成的字典(子类需重写)
 *
 *  @return 解析完成的字典
 */

+ (NSDictionary *)JSONDictionary;
@end
