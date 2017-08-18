//
//  MHQViewCell.m
//  YiAi
//
//  Created by lijunjie on 2017/7/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MHQViewCell.h"


@interface MHQViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *mieLabel;
@property (nonatomic, strong) UILabel *statuLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *numLabel;
@end
@implementation MHQViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI
{
    self.contentView.backgroundColor=[UIColor whiteColor];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width)];
    [self.contentView addSubview:_imageV];
  
    _mieLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.width+10, self.bounds.size.width-10, 20)];
    [self.contentView addSubview:_mieLabel];
    
    _statuLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.width+30, self.bounds.size.width-10, 20)];
    [self.contentView addSubview:_statuLabel];
    
    _positionLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.width+50, self.bounds.size.width-10, 20)];
    [self.contentView addSubview:_positionLabel];

    _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.width+70, self.bounds.size.width-10, 20)];
    [self.contentView addSubview:_numLabel];
    
    _mieLabel.font=[UIFont systemFontOfSize:15];
    _statuLabel.font=[UIFont systemFontOfSize:15];
    _positionLabel.font=[UIFont systemFontOfSize:15];
    _numLabel.font=[UIFont systemFontOfSize:15];
    _numLabel.textColor=[UIColor colorWithHexString:@"0x999999"];

}

-(void)updateWithModel:(MHQModel *)model{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.nfcFarImg]];
    _mieLabel.text=model.deviceName;
    _statuLabel.text=[NSString stringWithFormat:@"状态:%@",model.status];
    _positionLabel.text=[NSString stringWithFormat:@"位置:%@",model.position];
    _numLabel.text=[NSString stringWithFormat:@"编号:%@",model.nfcCode];
}
@end
