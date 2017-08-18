//
//  RCSegmentView.m
//  ProjectOne
//
//  Created by RongCheng on 16/3/31.
//  Copyright © 2016年 JiYue.com. All rights reserved.
//

#import "SegmentView.h"

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC
{
    if ( self=[super initWithFrame:frame  ])
    {
        self.controllers=controllers;
        self.nameArray=titleArray;
        
        
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        self.segmentView.tag=50;
        [self addSubview:self.segmentView];
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height -40)];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, 40);
            btn.tag=i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[AppAppearance sharedAppearance].mainColor forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[MyAdapter fontADapter:16];
            if (i==0){
                btn.selected=YES ;
                self.seleBtn=btn;
                //btn.titleLabel.font=[UIFont systemFontOfSize:16];
            } else {
                btn.selected=NO;
            }
            
            [self.segmentView addSubview:btn];
        }
        self.line=[[UILabel alloc]initWithFrame:CGRectMake(0,35, frame.size.width/self.controllers.count, 2)];
//        self.line.backgroundColor=[AppAppearance sharedAppearance].segementBootomLineColor;
        self.line.backgroundColor = [AppAppearance sharedAppearance].mainColor;
        self.line.tag=100;
        [self.segmentView addSubview:self.line];
        
        self.segmentView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        self.down=[[UILabel alloc]initWithFrame:CGRectMake(0, 38, frame.size.width, 3)];
        self.down.backgroundColor=[AppAppearance sharedAppearance].pageBackgroundColor;
        [self.segmentView addSubview:self.down];
    }
    
    
    return self;
}
- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font= [MyAdapter fontADapter:16];
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font= [MyAdapter fontADapter:16];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
  
//    if (sender.tag == 0) {
//        
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"Order0" object:nil userInfo:nil];
//    }else if (sender.tag == 1){
//    
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"Order1" object:nil userInfo:nil];
//    }else if (sender.tag == 2){
//        
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"Order2" object:nil userInfo:nil];
//    
//        
//    }
   
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
    
//    int typeid=self.segmentScrollV.contentOffset.x/self.frame.size.width;
//    
//    if (typeid == 0) {
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Order0" object:nil userInfo:nil];
//    }else if (typeid == 1){
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Order1" object:nil userInfo:nil];
//    }else if (typeid == 2){
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Order2" object:nil userInfo:nil];
//        
//        
//    }

    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
