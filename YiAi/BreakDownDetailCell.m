//
//  BreakDownDetailCell.m
//  YiAi
//
//  Created by zlkj on 2017/6/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BreakDownDetailCell.h"

@implementation BreakDownDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}



-(void)createSubViews
{
    
    
    self.typelbl = [[UILabel alloc] init];
//    self.typelbl.textColor = [AppAppearance sharedAppearance].redColor;
    self.typelbl.font = [MyAdapter fontADapter:16];
    [self addSubview:self.typelbl];
    
    
    self.titleLbl = [[UILabel alloc] init];
//    self.titleLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    self.titleLbl.font = [MyAdapter fontADapter:16];
    [self addSubview:self.titleLbl];
    
    
    self.timeLbl = [[UILabel alloc] init];
//    self.timeLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    self.timeLbl.font = [MyAdapter fontADapter:12];
    [self addSubview:self.timeLbl];
    
}





-(void)layoutSubviews

{
    [super layoutSubviews];
    
    
    CGFloat viewW = self.frame.size.width;
    
    self.typelbl.frame = CGRectMake(20, 10+[MyAdapter aDapter:7]/2, [MyAdapter aDapter:16], [MyAdapter aDapter:16]);
    self.typelbl.layer.masksToBounds = YES;
    self.typelbl.layer.cornerRadius = [MyAdapter aDapter:16]/2;
    self.typelbl.layer.borderWidth = 2;
    
    
    self.titleLbl.frame = CGRectMake(CGRectGetMaxX(self.typelbl.frame)+20, 10, viewW-CGRectGetMaxX(self.typelbl.frame)-20, [MyAdapter aDapter:21]);
    self.timeLbl.frame = CGRectMake(CGRectGetMaxX(self.typelbl.frame)+20, CGRectGetMaxY(self.titleLbl.frame), viewW-CGRectGetMaxX(self.typelbl.frame)-20, [MyAdapter aDapter:21]);
    
    
}


+(instancetype)breakDownDetailCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"BreakDownDetailCell";
    
    BreakDownDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[BreakDownDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
