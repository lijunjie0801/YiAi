//
//  HomeViewCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/7.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HomeViewCell.h"
#import "HomeModel.h"


@interface HomeViewCell()


@property(nonatomic, strong) UIImageView *headImg,*logoImg,*logoImg2;
@property(nonatomic, strong) UILabel *namelbl,*logolbl,*logo2lbl,*scorelbl,*scoreNamelbl;
@property(nonatomic, strong) UIButton *typeBtn;



@end


@implementation HomeViewCell


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
    
    
    self.logoImg = [[UIImageView alloc] init];
    [self addSubview:self.logoImg];
    
    
    self.logoImg2 = [[UIImageView alloc] init];
    [self addSubview:self.logoImg2];
    
    self.namelbl = [[UILabel alloc] init];
    self.namelbl.font = [MyAdapter fontADapter:16];
    self.namelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:self.namelbl];
    
    self.logolbl = [[UILabel alloc] init];
    self.logolbl.font = [MyAdapter fontADapter:12];
    self.logolbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [self addSubview:self.logolbl];
    
    
    self.logo2lbl = [[UILabel alloc] init];
    self.logo2lbl.font = [MyAdapter fontADapter:12];
    self.logo2lbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    [self addSubview:self.logo2lbl];
    
    self.scorelbl = [[UILabel alloc] init];
    self.scorelbl.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]];
    self.scorelbl.textColor = [AppAppearance sharedAppearance].yellowColor;
    self.scorelbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.scorelbl];
    
    self.scoreNamelbl = [[UILabel alloc] init];
    self.scoreNamelbl.font = [MyAdapter fontADapter:12];
    self.scoreNamelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    self.scoreNamelbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.scoreNamelbl];
    
    self.typeBtn = [[UIButton alloc] init];
    self.typeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:12]];
    [self addSubview:self.typeBtn];
    
    
    
    
    self.headImg.image = [UIImage imageNamed:@"default1"];
    self.logoImg.image = [UIImage imageNamed:@"辖区"];
    self.logoImg2.image = [UIImage imageNamed:@"维保公司"];
//    self.namelbl.text = @"安徽国际金融中心";
//    self.logolbl.text = @"蜀山消防支付";
//    self.logo2lbl.text = @"依爱维保";
//    self.scorelbl.text = @"6.2/分";
    self.scoreNamelbl.text = @"维保综合得分";
    
    [self.typeBtn setTitle:@"安全项目" forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:[AppAppearance sharedAppearance].mainColor forState:UIControlStateNormal];
    self.typeBtn.backgroundColor = [[AppAppearance sharedAppearance].mainColor colorWithAlphaComponent:0.1];
    
    
}


-(void)setModel:(HomeModel *)model
{
    _model = model;
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.projectImg] placeholderImage:[UIImage imageNamed:@"default1"]];
    self.namelbl.text = model.projectName;
    self.logolbl.text = model.projectFireName;
    self.logo2lbl.text = model.projectProtectName;
    self.scorelbl.text = [NSString stringWithFormat:@"%@/分",model.projectStore];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    
    
    self.headImg.frame = CGRectMake(10, 10, [MyAdapter aDapter:100], [MyAdapter aDapter:100]);
    
    self.namelbl.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, 10, viewW-CGRectGetMaxX(self.headImg.frame)-10-10, [MyAdapter aDapter:21]);
    
    self.logoImg.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, CGRectGetMaxY(self.namelbl.frame)+5, [MyAdapter aDapter:15], [MyAdapter aDapter:15]);
    self.logolbl.frame = CGRectMake(CGRectGetMaxX(self.logoImg.frame)+5, CGRectGetMaxY(self.namelbl.frame)+2, viewW-CGRectGetMaxX(self.logoImg.frame)-5, [MyAdapter aDapter:21]);
    
    
     CGFloat scoreW = [self.typeBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:25]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]]} context:nil].size.width+10;
    
    self.scorelbl.frame = CGRectMake(viewW - scoreW - 10, CGRectGetMaxY(self.logolbl.frame), scoreW, [MyAdapter aDapter:25]);
    
    CGFloat scoreNameW = [self.scoreNamelbl.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:12]} context:nil].size.width+10;
    
    self.scoreNamelbl.frame = CGRectMake(viewW - scoreNameW - 10, CGRectGetMaxY(self.scorelbl.frame), scoreNameW, [MyAdapter aDapter:21]);
    
    
    
    
    
    
    self.logoImg2.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, CGRectGetMaxY(self.logolbl.frame)+5, [MyAdapter aDapter:15], [MyAdapter aDapter:15]);
    self.logo2lbl.frame = CGRectMake(CGRectGetMaxX(self.logoImg2.frame)+5, CGRectGetMaxY(self.logolbl.frame)+2, viewW - CGRectGetMaxX(self.logoImg2.frame)-5 - scoreW -10  , [MyAdapter aDapter:21]);
    
    
     CGFloat typeW = [self.typeBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:25]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:12]]} context:nil].size.width+10;
    
    self.typeBtn.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+5, viewH-10-[MyAdapter aDapter:25], typeW, [MyAdapter aDapter:25]);
    self.typeBtn.layer.masksToBounds = YES;
    self.typeBtn.layer.cornerRadius = 6;
    
    
    
    
    
    
    
}








+(instancetype)homeViewCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"homeCell";
    
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[HomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
