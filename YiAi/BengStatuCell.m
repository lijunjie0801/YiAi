//
//  BengStatuCell.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BengStatuCell.h"

@implementation BengStatuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    self.statuImg=[[UIImageView alloc]init];
    [self addSubview:_statuImg];
    
    self.statuLbl=[[UILabel alloc]init];
    [self addSubview:_statuLbl];
    
    self.addressLbl=[[UILabel alloc]init];
    [self addSubview:_addressLbl];
    
    self.remarkLbl=[[UILabel alloc]init];
    [self addSubview:_remarkLbl];
    
    self.timeLbl=[[UILabel alloc]init];
    [self addSubview:_timeLbl];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.statuImg.frame=CGRectMake((kScreen_Width-190)/2, 20, 190, 144);
    _statuLbl.frame=CGRectMake(80, 184, kScreen_Width-80, 20);
    _addressLbl.frame=CGRectMake(80, 214, kScreen_Width-80, 20);
    _remarkLbl.frame=CGRectMake(80, 244, kScreen_Width-80, 20);
    _timeLbl.frame=CGRectMake(80, 274, kScreen_Width-80, 20);
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 304, kScreen_Width, 10)];
    v.backgroundColor=[UIColor colorWithHexString:@"eeeeee"];
    [self addSubview:v];
    
    
}












+(instancetype)bengStatuCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"Cell";
    
    BengStatuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[BengStatuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(BengStatuModel *)model{
    if ([model.status isEqualToString:@"开启"]) {
        _statuImg.image=[UIImage imageNamed:@"openS"];
    }else{
        _statuImg.image=[UIImage imageNamed:@"closeS"];
    }
    _statuLbl.text=[NSString stringWithFormat:@"状态:%@",model.status];
    _addressLbl.text=[NSString stringWithFormat:@"位置:%@",model.localPosition];
    _remarkLbl.text=[NSString stringWithFormat:@"注释:%@",model.note];
    _timeLbl.text=[NSString stringWithFormat:@"时间:%@",model.time];
    
}


@end
