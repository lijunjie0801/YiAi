//
//  WebViewJS.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "WebViewJS.h"

@implementation WebViewJS

-(void)photo{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(photoJS)]) {
            [self.delegate photoJS];
        }
    });
}
@end

