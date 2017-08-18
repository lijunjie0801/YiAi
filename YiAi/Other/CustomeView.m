//
//  CustomeView.m
//  YiAi
//
//  Created by lijunjie on 2017/8/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CustomeView.h"

@implementation CustomeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    self.imageview=[[UIImageView alloc]init];
    self.imageview.frame=CGRectMake(15, 15,25,25);
    [self addSubview:self.imageview];
    
    self.label=[[UILabel alloc]init];
    self.label.frame=CGRectMake(50, 10,200,35);
    self.label.numberOfLines=0;
    self.label.font=[UIFont systemFontOfSize:17];
    self.label.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.label];
    
    UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 54, kScreen_Width, 1)];
    sepview.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [self addSubview:sepview];
    
    UIImageView *rightview=[[UIImageView alloc]init];
    rightview.frame=CGRectMake(kScreen_Width-35, 17.5,20,20);
    rightview.image=[UIImage imageNamed:@"you"];
    [self addSubview:rightview];
}

@end
