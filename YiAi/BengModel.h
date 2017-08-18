//
//  BengModel.h
//  YiAi
//
//  Created by lijunjie on 2017/7/26.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BengModel : NSObject
@property(nonatomic, strong) NSString *hostId;
@property(nonatomic, strong) NSArray *ProjectPersonMessagesList;
@property (nonatomic, assign, getter=isFolded) BOOL folded;
@end
