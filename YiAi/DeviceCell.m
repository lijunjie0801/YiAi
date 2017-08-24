//
//  DeviceCell.m
//  YiAi
//
//  Created by lijunjie on 2017/7/27.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "DeviceCell.h"

@implementation DeviceCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    self.numLbl=[[UILabel alloc]init];
    [self addSubview:_numLbl];
    CGFloat proWidth=kScreen_Width-120;
    self.progressView = [[VoltageView alloc] initWithFrame:CGRectMake(60, 100, proWidth, proWidth)];
    //self.progressView.startAngle = [MyAdapter aDapter:200]/2;
    self.progressView.trackBackgroundColor = [[AppAppearance sharedAppearance].mainColor colorWithAlphaComponent:0.3];
    self.progressView.trackColor = [AppAppearance sharedAppearance].mainColor;
    self.progressView.headerImage = [self drawImage];
    self.progressView.progressLabel.textColor = [UIColor blueColor];
    [self addSubview:self.progressView];
    CGFloat backgroundWidth=kScreen_Width-160;
    CGFloat backgroundHeihgt=backgroundWidth*246/498;
    CGFloat backgroundY=100+(proWidth/2-backgroundHeihgt)+(backgroundHeihgt*0.2);
    self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width-backgroundWidth)/2, backgroundY, backgroundWidth,backgroundHeihgt)];
    self.backgroundImg.image = [UIImage  imageNamed:@"point"];
    [self addSubview:self.backgroundImg];
    self.pointImg = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundWidth-64)/2+2, backgroundHeihgt*0.8-32+backgroundHeihgt*0.1, [MyAdapter aDapter:64], [MyAdapter aDapter:32])];
    self.pointImg.image = [UIImage imageNamed:@"椭圆-1"];
    [self.backgroundImg bringSubviewToFront:self.pointImg];
    [self.backgroundImg addSubview:self.pointImg];
    self.pointImg.layer.anchorPoint = CGPointMake(0.73,0.4);
    self.progressView.progress = 3/0.003/1000*0.03*0.75;
    CGFloat progress = self.progressView.progress*100;
    self.pointImg.transform = CGAffineTransformMakeRotation(progress*M_PI/100);
    
    _lb1=[[UILabel alloc]initWithFrame:CGRectMake(5, backgroundHeihgt*0.8-10, 50, 20)];
    _lb2=[[UILabel alloc]initWithFrame:CGRectMake(backgroundWidth/4-25, backgroundHeihgt*0.2+10, 50, 20)];
    _lb3=[[UILabel alloc]initWithFrame:CGRectMake((backgroundWidth-50)/2, 10, 50, 20)];
    _lb4=[[UILabel alloc]initWithFrame:CGRectMake(backgroundWidth-(backgroundWidth/4-25+50), backgroundHeihgt*0.2+10, 50, 20)];
    _lb5=[[UILabel alloc]initWithFrame:CGRectMake(backgroundWidth-55, backgroundHeihgt*0.8-10, 50, 20)];
    _lb1.textAlignment=NSTextAlignmentCenter;
     _lb2.textAlignment=NSTextAlignmentCenter;
     _lb3.textAlignment=NSTextAlignmentCenter;
     _lb4.textAlignment=NSTextAlignmentCenter;
     _lb5.textAlignment=NSTextAlignmentCenter;
    _lb1.textColor=[UIColor colorWithHexString:@"0x8fb7f6"];
    _lb2.textColor=[UIColor colorWithHexString:@"0x8fb7f6"];
    _lb3.textColor=[UIColor colorWithHexString:@"0x8fb7f6"];
    _lb4.textColor=[UIColor colorWithHexString:@"0x8fb7f6"];
    _lb5.textColor=[UIColor colorWithHexString:@"0x8fb7f6"];
    [self.backgroundImg addSubview:self.lb1];
    [self.backgroundImg addSubview:self.lb2];
    [self.backgroundImg addSubview:self.lb3];
    [self.backgroundImg addSubview:self.lb4];
    [self.backgroundImg addSubview:self.lb5];
    
    self.addressLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 130+proWidth/2, kScreen_Width-60, 20)];
    _addressLbl.font=[UIFont systemFontOfSize:15];
    _addressLbl.textColor=[UIColor colorWithHexString:@"0x999999"];
    [self addSubview:_addressLbl];
    
    self.qujianLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 160+proWidth/2, kScreen_Width-60, 20)];
    _qujianLbl.font=[UIFont systemFontOfSize:15];
    _qujianLbl.textColor=[UIColor colorWithHexString:@"0x999999"];
    [self addSubview:_qujianLbl];

    self.remarkLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 190+proWidth/2, kScreen_Width-60, 20)];
    _remarkLbl.font=[UIFont systemFontOfSize:15];
    _remarkLbl.textColor=[UIColor colorWithHexString:@"0x999999"];
    [self addSubview:_remarkLbl];
    
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 220+proWidth/2, kScreen_Width, 10)];
    v.backgroundColor=[UIColor colorWithHexString:@"eeeeee"];
    [self addSubview:v];

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.numLbl.frame=CGRectMake(0, 20, kScreen_Width, 60);
    self.numLbl.font=[UIFont boldSystemFontOfSize:40];
    self.numLbl.textColor=[UIColor colorWithHexString:@"0xff7235"];
    self.numLbl.textAlignment=NSTextAlignmentCenter;
    
   
    
}












+(instancetype)taskBooksCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"TaskBooksCell";
    
    DeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[DeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(DeviceModel *)model{
    self.numLbl.text=model.voltageValue;
    CGFloat current=[model.voltageValue floatValue];
    CGFloat min=[model.thresholdDownLimit floatValue];
    CGFloat max=[model.thresholdUpLimit floatValue];
    CGFloat du=(current-min)/(max-min);
    if (current<min) {
        du=0;
    }else if(current>max){
        //self.progressView.trackColor=[UIColor redColor];
        du=1;
    }else{
        du=(current-min)/(max-min);
    }
    
    self.progressView.progress = 3/0.003/1000*0.03*du;

    CGFloat progress ;
    if (current<min) {
        progress=-10;
    }else if(current>max){
       progress=110;
    }else{
        progress= self.progressView.progress*100;
    }
    self.pointImg.transform = CGAffineTransformMakeRotation(progress*M_PI/100);
     _lb1.text=model.thresholdDownLimit;
    _lb5.text=model.thresholdUpLimit;
    if ([model.thresholdUpLimit integerValue]>0) {
        NSInteger cha=[model.thresholdUpLimit integerValue]-[model.thresholdDownLimit integerValue];
        _lb2.text=[NSString stringWithFormat:@"%ld",[model.thresholdDownLimit integerValue]+cha/4];
        _lb3.text=[NSString stringWithFormat:@"%ld",[model.thresholdDownLimit integerValue]+cha/2];
        _lb4.text=[NSString stringWithFormat:@"%ld",[model.thresholdDownLimit integerValue]+cha/4*3];
    }else{
        CGFloat cha=[model.thresholdUpLimit floatValue]-[model.thresholdDownLimit floatValue];
        _lb2.text=[NSString stringWithFormat:@"%.1f",[model.thresholdDownLimit floatValue]+cha/4];
        _lb3.text=[NSString stringWithFormat:@"%.1f",[model.thresholdDownLimit floatValue]+cha/2];
        _lb4.text=[NSString stringWithFormat:@"%.1f",[model.thresholdDownLimit floatValue]+cha/4*3];
    }
    self.addressLbl.text=[NSString stringWithFormat:@"位置:%@",model.localPosition];
     self.qujianLbl.text=[NSString stringWithFormat:@"正常区间:%@-%@",model.thresholdDownLimit,model.thresholdUpLimit];
    self.remarkLbl.text=[NSString stringWithFormat:@"注释:%@",model.note];

}


- (UIImage *)drawImage {
    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddArc(currentContext, 10, 10, 10, 0, 2*M_PI, 0);
    [[UIColor whiteColor] set];
    CGContextFillPath(currentContext);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
