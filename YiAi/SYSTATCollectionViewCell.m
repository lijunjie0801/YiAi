//
//  SYSTATCollectionViewCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/7.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "SYSTATCollectionViewCell.h"

@interface SYSTATCollectionViewCell()

@end



@implementation SYSTATCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.btn = [[UIButton alloc] init];
//        self.btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.btn.titleLabel.font = [MyAdapter fontADapter:12];
     //   [self.btn setTitleColor:[AppAppearance sharedAppearance].titleTextColor forState:UIControlStateNormal];
        //self.btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.btn.userInteractionEnabled = NO;
        [self addSubview:self.btn];
        
        self.lab=[[UILabel alloc]init];
        [self addSubview:self.lab];
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewW=[MyAdapter aDapter:55];
    
    self.btn.frame = CGRectMake(10, 0, self.bounds.size.width-20, self.bounds.size.width-40);
    self.lab.frame=CGRectMake(0, self.bounds.size.width-30, self.bounds.size.width, 20);
    self.lab.textAlignment=NSTextAlignmentCenter;
    self.lab.font=[UIFont systemFontOfSize:12];
//    self.btn.titleEdgeInsets = UIEdgeInsetsMake(10, -[MyAdapter aDapter:60], -[MyAdapter aDapter:60], -[MyAdapter aDapter:5]);
//    self.btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    
}



@end
