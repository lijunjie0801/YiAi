//
//  UserBehaviorsTableViewCell.m
//  GZB
//
//  Created by fyaex001 on 16/3/23.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "UserBehaviorsTableViewCell.h"

@interface UserBehaviorsTableViewCell()<UITextFieldDelegate>

@property(nonatomic, strong) UIView *line;

@end

@implementation UserBehaviorsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        _lblName      = [[UILabel alloc] init];
        _lblName.font = [MyAdapter fontADapter:16];
        _lblName.textColor = [AppAppearance sharedAppearance].titleTextColor;
        [self.contentView addSubview:_lblName];
        
        _textField                          = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.font                     = [MyAdapter fontADapter:14];
        _textField.borderStyle              = UITextBorderStyleNone;
        _textField.returnKeyType            = UIReturnKeyDone;
        _textField.textAlignment            = NSTextAlignmentRight;
        _textField.backgroundColor          = [UIColor clearColor];
//        _textField.clearButtonMode          = UITextFieldViewModeWhileEditing;
        _textField.delegate                 = self;
        _textField.textColor = [AppAppearance sharedAppearance].title3TextColor;
        [self.contentView addSubview:_textField];
        
        _changeBtn=[[UILabel alloc]init];
//        [_changeBtn setTitle:@"哈哈" forState:UIControlStateNormal];
//        [_changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _changeBtn.text=@"hsj";
        [self.contentView addSubview:_changeBtn];
        
        _line                               = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
        [self.contentView addSubview:_line];
        
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //    CGFloat offset = [MyAdapter aDapter:65];
    //    if (self.accessoryView) {
    //        _textField.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 46, CGRectGetWidth(self.contentView.bounds)- offset - 30 + 35, 46);
    //    }else{
    //        _textField.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 46, CGRectGetWidth(self.contentView.bounds) - offset - 30 - 39, 46);
    //    }
    
    self.lblName.frame = CGRectMake(10, 0, [MyAdapter aDapter:90], self.frame.size.height);
    
    _textField.frame = CGRectMake(CGRectGetMaxX(self.lblName.frame)+5, 0, WIDTH-CGRectGetMaxX(self.lblName.frame)-5-10, 46);
    _changeBtn.frame=CGRectMake(kScreen_Width-150-10, 0, 150, 46);
    _changeBtn.textAlignment=NSTextAlignmentRight;
    //_changeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    
    
    _line.frame = CGRectMake(0, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.contentView.bounds), 0.6);
    
    
}




+(instancetype)userBehaviorsTableViewCellWithTableView:(UITableView *)tableView
{
    
    static NSString *identifier = @"userBehaviorsTableViewCell";
    
    UserBehaviorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UserBehaviorsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

