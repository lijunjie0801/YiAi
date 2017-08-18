//
//  BackBtn.h
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackBtnDelegate<NSObject>
-(void)goback;
@end
@interface BackBtn : UIView
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,weak)id<BackBtnDelegate> delegate;
@end
