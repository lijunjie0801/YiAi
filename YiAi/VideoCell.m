//
//  VideoCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "VideoCell.h"



@interface VideoCell()

@property(nonatomic, strong) UIImageView *videoImg;
@property(nonatomic, strong) UILabel *titleLbl,*detailLbl;
@property(nonatomic, strong) UIButton *typeBtn;

@end

@implementation VideoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    self.videoImg = [[UIImageView alloc] init];
    [self addSubview:self.videoImg];
    
    self.titleLbl = [[UILabel alloc] init];
    self.titleLbl.font = [MyAdapter fontADapter:16];
    self.titleLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self addSubview:self.titleLbl];
    
    self.detailLbl = [[UILabel alloc] init];
    self.detailLbl.font = [MyAdapter fontADapter:14];
    self.detailLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    [self addSubview:self.detailLbl];
    
    
    self.typeBtn = [[UIButton alloc] init];
    self.typeBtn.backgroundColor = [AppAppearance sharedAppearance].yellowColor;
    [self.typeBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    self.typeBtn.titleLabel.font = [MyAdapter fontADapter:14];
    [self addSubview:self.typeBtn];
    
    self.videoImg.image = [UIImage imageNamed:@"default1"];
    self.titleLbl.text = @"1号楼12层12分区";
    self.detailLbl.text = @"设计组办公室";
    
    [self.typeBtn setTitle:@"视频1" forState:UIControlStateNormal];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    
    CGFloat imgW = [MyAdapter aDapter:120];
    self.videoImg.frame = CGRectMake(10, 10, imgW, imgW*9/16);
    
    self.titleLbl.frame = CGRectMake(CGRectGetMaxX(self.videoImg.frame)+10, 10, viewW -CGRectGetMaxX(self.videoImg.frame)-10-10, [MyAdapter aDapter:21]);
    self.detailLbl.frame = CGRectMake(CGRectGetMaxX(self.videoImg.frame)+10, CGRectGetMaxY(self.titleLbl.frame), viewW -CGRectGetMaxX(self.videoImg.frame)-10-10, [MyAdapter aDapter:21]);
    
    
    CGFloat typeW = [self.typeBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:14]]} context:nil].size.width+10;
    
    self.typeBtn.frame = CGRectMake(CGRectGetMaxX(self.videoImg.frame)+10, viewH-10-[MyAdapter aDapter:21], typeW, [MyAdapter aDapter:21]);
    
}







+(instancetype)videoCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"VideoCell";
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
