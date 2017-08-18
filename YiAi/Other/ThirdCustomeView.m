//
//  ThirdCustomeView.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ThirdCustomeView.h"

@implementation ThirdCustomeView

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
    CGFloat width=kScreen_Width/4/3;
    self.imageview.frame=CGRectMake((kScreen_Width/4-width)/2, 20,width,width);
    //self.imageview.backgroundColor=[UIColor greenColor];
    [self addSubview:self.imageview];
    
    self.label=[[UILabel alloc]init];
  //  self.label.textColor=[UIColor grayColor];
    self.label.frame=CGRectMake(0, 30+width,kScreen_Width/4,40);
    self.label.numberOfLines=0;
    self.label.font=[UIFont systemFontOfSize:15];
    self.label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.label];
}



@end
