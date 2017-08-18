//
//  PeopleManageCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PeopleManageCell.h"



@interface PeopleManageCell()

@property(nonatomic, strong) UIImageView *headImg;
@property(nonatomic, strong) UILabel *nameLbl,*detailLbl;
@property(nonatomic, strong) UIButton *callBtn;

@end

@implementation PeopleManageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    self.headImg = [[UIImageView alloc] init];
    [self addSubview:self.headImg];
    
    self.nameLbl = [[UILabel alloc] init];
    self.nameLbl.font = [MyAdapter fontADapter:16];
    self.nameLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:self.nameLbl];
    
    self.detailLbl = [[UILabel alloc] init];
    self.detailLbl.font = [MyAdapter fontADapter:14];
    self.detailLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    [self addSubview:self.detailLbl];
    
    
    self.callBtn = [[UIButton alloc] init];
    [self.callBtn setTitleColor:[AppAppearance sharedAppearance].mainColor forState:UIControlStateNormal];
    [self.callBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    self.callBtn.titleLabel.font = [MyAdapter fontADapter:14];
    [self.callBtn setImage:[UIImage imageNamed:@"callphone"] forState:UIControlStateNormal];
    [self.callBtn addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    self.callBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.callBtn];
    
    self.headImg.image = [UIImage imageNamed:@"default1"];
    self.nameLbl.text = @"刘亦菲";
    self.detailLbl.text = @"管理人员";
    
    
}
-(void)call{
    [self.delegate Call:self.indexSection :self.indexRow];
}
-(void)updateWithDic:(NSDictionary *)dic{
    [self.callBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    self.nameLbl.text=dic[@"personName"];
    self.detailLbl.text=dic[@"professionalTile"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:dic[@"PhotoUrl"]] placeholderImage:[UIImage imageNamed:@"default1"]];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
//    CGFloat ViewH = self.frame.size.height;
    

    CGFloat imgWH = [MyAdapter aDapter:60];
    
    self.headImg.frame = CGRectMake(10, 10, imgWH, imgWH);
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = imgWH/2;
    
    self.nameLbl.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, 10+(imgWH - [MyAdapter aDapter:42])/2, viewW -CGRectGetMaxX(self.headImg.frame)-10 - [MyAdapter aDapter:80]-10 , [MyAdapter aDapter:21]);
    
    self.detailLbl.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, CGRectGetMaxY(self.nameLbl.frame),  viewW -CGRectGetMaxX(self.headImg.frame)-10 - [MyAdapter aDapter:80]-10, [MyAdapter aDapter:21]);
    
    self.callBtn.frame = CGRectMake(viewW-[MyAdapter aDapter:80]-10, 10+(imgWH - [MyAdapter aDapter:25])/2, [MyAdapter aDapter:80], [MyAdapter aDapter:25]);
    
    self.callBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -[MyAdapter aDapter:5], 0, 0);
}





+(instancetype)peopleManageCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"PeopleManageCell";
    
    PeopleManageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[PeopleManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
