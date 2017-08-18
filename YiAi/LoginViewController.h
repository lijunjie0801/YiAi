//
//  LoginViewController.h
//  YiAi
//
//  Created by zlkj on 2017/6/20.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseViewController.h"
@protocol BaseViewDelegate <NSObject>
-(void)refresh;
@end
@interface LoginViewController : BaseViewController
@property(nonatomic, weak) id<BaseViewDelegate> delegate;
@end
