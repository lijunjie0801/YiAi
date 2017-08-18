//
//  UserBehaviorsTableViewCell.h
//  YiAi
//
//  Created by zlkj on 2017/6/26.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserBehaviorsTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel     *lblName;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UILabel *changeBtn;
@property (nonatomic,copy) void(^selectBtnChange)(NSString *content,NSString *indexrow);

+(instancetype)userBehaviorsTableViewCellWithTableView:(UITableView *)tableView;

@end
