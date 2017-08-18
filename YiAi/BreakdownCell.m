//
//  BreakdownCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BreakdownCell.h"
#import "FireModel.h"
#import "WaterModel.h"
#import "BreakModel.h"
#import "XFModel.h"
@interface BreakdownCell()


@property(nonatomic, strong) UIView *contentViews;
@property(nonatomic, strong) UIButton *typeBtn;
@property(nonatomic, strong) UIView *cellView;
@property(nonatomic, strong) UILabel *titleLbl,*detailLbl,*addressLbl,*timeLbl;


@end

@implementation BreakdownCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    
    self.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    self.contentViews = [[UIView alloc] init];
    self.contentViews.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [self addSubview:self.contentViews];
    
    
    
    self.titleLbl = [[UILabel alloc] init];
    self.titleLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    self.titleLbl.font = [MyAdapter fontADapter:16];
    [self.contentViews addSubview:self.titleLbl];
    
    self.detailLbl = [[UILabel alloc] init];
    self.detailLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    self.detailLbl.font = [MyAdapter fontADapter:14];
    [self.contentViews addSubview:self.detailLbl];
    
    
    
    self.cellView = [[UIView alloc] init];
    self.cellView.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
    [self.contentViews addSubview:self.cellView];
    
    
    self.typeBtn = [[UIButton alloc] init];
    self.typeBtn.titleLabel.font = [MyAdapter fontADapter:14];
    self.typeBtn.backgroundColor = [AppAppearance sharedAppearance].yellowColor;
    [self.contentViews addSubview:self.typeBtn ];
    
    
    self.addressLbl = [[UILabel alloc] init];
    self.addressLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    self.addressLbl.font = [MyAdapter fontADapter:14];
    [self.contentViews addSubview:self.addressLbl];
    
    self.timeLbl = [[UILabel alloc] init];
    self.timeLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    self.timeLbl.textAlignment = NSTextAlignmentRight;
    self.timeLbl.font = [MyAdapter fontADapter:12];
    [self.contentViews addSubview:self.timeLbl];
    
    
    
    self.titleLbl.text = @"1号楼12层12分区";
    self.detailLbl.text = @"设计组办公室";
    self.addressLbl.text = @"黄山大厦A座";
    self.timeLbl.text = @"2015/06/07";
    [self.typeBtn setTitle:@"故障" forState:UIControlStateNormal];
    
    
}


-(void)setFireModel:(FireModel *)fireModel
{
    _fireModel = fireModel;
    
    self.titleLbl.text = fireModel.projectName;
    self.detailLbl.text = fireModel.alarmModule;
    self.addressLbl.text = fireModel.address;
    self.timeLbl.text = fireModel.time;
    
    [self.typeBtn setTitle:fireModel.alarmContent forState:UIControlStateNormal];
    
}
-(void)setXfModel:(XFModel *)xfModel{
    _xfModel = xfModel;
    
    self.titleLbl.text = xfModel.hostId;
    self.detailLbl.text = xfModel.localPosition;
    self.addressLbl.text = xfModel.basePosition;
    self.timeLbl.text = xfModel.alarmTime;
    
    [self.typeBtn setTitle:xfModel.controlTypeGet forState:UIControlStateNormal];
    

}

-(void)setWaterModel:(WaterModel *)waterModel
{
    _waterModel = waterModel;
    
    self.titleLbl.text = waterModel.projectName;
    self.detailLbl.text = [NSString stringWithFormat:@"%@：%@",waterModel.devType,waterModel.dataValue];
    self.addressLbl.text = waterModel.note;
    self.timeLbl.text = waterModel.time;
    
    [self.typeBtn setTitle:waterModel.status forState:UIControlStateNormal];
    
}
-(void)setBreakModel:(BreakModel *)breakModel{
    _breakModel = breakModel;
    
    self.titleLbl.text = breakModel.projectName;
    self.detailLbl.text = breakModel.alarmModule;
    self.addressLbl.text = breakModel.address;
    self.timeLbl.text = breakModel.time;
    
    [self.typeBtn setTitle:breakModel.alarmContent forState:UIControlStateNormal];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
//    CGFloat viewH = self.frame.size.height;
    
    
    self.contentViews.frame = CGRectMake(10, 0, viewW-20, [MyAdapter aDapter:63]+36);
    
    self.titleLbl.frame = CGRectMake(10, 10, viewW-20, [MyAdapter aDapter:21]);
    
    
     CGFloat typeW = [self.typeBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:14]} context:nil].size.width+20;
    
    self.typeBtn.frame = CGRectMake(viewW-20-10-typeW, CGRectGetMaxY(self.titleLbl.frame)+5, typeW, [MyAdapter aDapter:21]);
    
    self.detailLbl.frame = CGRectMake(10, CGRectGetMaxY(self.titleLbl.frame)+5, viewW-20-20-typeW-10, [MyAdapter aDapter:21]);
    
    self.cellView.frame = CGRectMake(0, CGRectGetMaxY(self.detailLbl.frame)+5, viewW-20, 1);
    
    
     CGFloat timeW = [self.timeLbl.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:12]} context:nil].size.width+10;
    
    self.timeLbl.frame = CGRectMake(viewW-20-10-timeW, CGRectGetMaxY(self.cellView.frame)+5, timeW, [MyAdapter aDapter:21]);
    self.addressLbl.frame = CGRectMake(10, CGRectGetMaxY(self.cellView.frame)+5, viewW-20-20-timeW-10, [MyAdapter aDapter:21]);
    
    
    
}

+(instancetype)breakDownCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"BreakdownCell";
    
    BreakdownCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[BreakdownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
