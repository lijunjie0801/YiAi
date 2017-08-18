//
//  XFListModel.h
//  YiAi
//
//  Created by lijunjie on 2017/8/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFListModel : NSObject
@property(nonatomic, strong) NSString *hostId;
@property(nonatomic, strong) NSArray *portAddressList;
@property (nonatomic, assign, getter=isFolded) BOOL folded;
@end
