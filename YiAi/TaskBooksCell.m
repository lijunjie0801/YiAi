//
//  TaskBooksCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "TaskBooksCell.h"


@interface TaskBooksCell()

@property(nonatomic, strong) UIView *contentViews;
@property(nonatomic, strong) UIView *cellView;



@end


@implementation TaskBooksCell

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
    
    
    
    self.headImg = [[UIImageView alloc] init];
    [self.contentViews addSubview:self.headImg];
    
    self.numLbl = [[UILabel alloc] init];
    self.numLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    self.numLbl.font = [MyAdapter fontADapter:14];
    [self.contentViews addSubview:self.numLbl];
    
    
    
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
    self.numLbl.text = @"0/16";
    self.addressLbl.text = @"黄山大厦A座";
    self.timeLbl.text = @"2015/06/07";
    [self.typeBtn setTitle:@"未分配" forState:UIControlStateNormal];
    self.headImg.image = [UIImage imageNamed:@"default1"];
    
    
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
    
    self.headImg.frame = CGRectMake(10, CGRectGetMaxY(self.titleLbl.frame)+5, [MyAdapter aDapter:21], [MyAdapter aDapter:21]);
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = [MyAdapter aDapter:21]/2;
    
    self.numLbl.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, CGRectGetMaxY(self.titleLbl.frame)+5, viewW-20-20-typeW-CGRectGetMaxX(self.headImg.frame)-10, [MyAdapter aDapter:21]);
    
    self.cellView.frame = CGRectMake(0, CGRectGetMaxY(self.numLbl.frame)+5, viewW-20, 1);
    
    
    CGFloat timeW = [self.timeLbl.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:12]} context:nil].size.width+10;
    
    self.timeLbl.frame = CGRectMake(viewW-20-10-timeW, CGRectGetMaxY(self.cellView.frame)+5, timeW, [MyAdapter aDapter:21]);
    self.addressLbl.frame = CGRectMake(10, CGRectGetMaxY(self.cellView.frame)+5, viewW-20-20-timeW-10, [MyAdapter aDapter:21]);
    
    
    
}












+(instancetype)taskBooksCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"TaskBooksCell";
    
    TaskBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[TaskBooksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setNFCModel:(NFCModel *)NFCModel{
    _NFCModel=NFCModel;
   // self.titleLbl.text = NFCModel.proCodeName;
    self.numLbl.text = NFCModel.nfcPatrolPerson;
    self.addressLbl.text = NFCModel.nfcRemark;
    self.timeLbl.text = NFCModel.nfcPatrolTime;
    [self.typeBtn setTitle:NFCModel.nfcStatus forState:UIControlStateNormal];
    self.typeBtn.backgroundColor =[UIColor colorWithHexString:@"0xff8133"];
    

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
