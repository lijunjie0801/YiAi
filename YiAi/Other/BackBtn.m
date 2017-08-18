//
//  BackBtn.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "BackBtn.h"

@implementation BackBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    [_backBtn addTarget:self action:@selector(webGoBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}
-(void)webGoBack{
    [self.delegate goback];
}
@end
