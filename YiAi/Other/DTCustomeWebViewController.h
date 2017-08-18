//
//  DTCustomeWebViewController.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/8.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol WebViewDelegate <NSObject>
-(void)twoback;
-(void)homeRefresh;
@end
@interface DTCustomeWebViewController : BaseViewController
@property(nonatomic,strong)NSString *webUrl;
@property(nonatomic, weak) id<WebViewDelegate> delegate;
@end
