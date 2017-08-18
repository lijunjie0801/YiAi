//
//  BBTextField.m
//  YiAi
//
//  Created by lijunjie on 2017/7/21.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BBTextField.h"

@interface BBTextField ()

@end


@implementation BBTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI
{
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 22;
    self.backgroundColor = [UIColor whiteColor];
   // self.layer.borderColor = Default_SeparatorColor.CGColor;
  //  self.layer.borderWidth = 1;
    self.font = [UIFont systemFontOfSize:12];
    //字体颜色
    self.textColor = [UIColor whiteColor];
    //光标颜色
    self.tintColor= [UIColor whiteColor];
    //占位符的颜色和大小
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    
}


//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}

@end
