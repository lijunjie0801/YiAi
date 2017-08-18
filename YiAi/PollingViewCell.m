//
//  PollingViewCell.m
//  YiAi
//
//  Created by lijunjie on 2017/7/19.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PollingViewCell.h"

@implementation PollingViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubViews];
        
    }
    return self;
}


-(void)createSubViews
{
    self.titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreen_Width-100, 20)];
    self.titleLbl.textColor=[UIColor grayColor];
    [self addSubview:self.titleLbl];
    CGFloat imgWidth=(kScreen_Width-100)/3;

    self.headImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40, imgWidth, imgWidth)];
    //imgView.backgroundColor=[UIColor redColor];
    [self addSubview:self.headImg];
    
    
}

+(instancetype)pollingViewCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"PollingViewCell";
    
    PollingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[PollingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
