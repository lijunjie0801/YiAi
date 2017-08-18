//
//  BreakDownDetailCell.h
//  YiAi
//
//  Created by zlkj on 2017/6/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakDownDetailCell : UITableViewCell

@property(nonatomic, strong) UILabel *titleLbl,*timeLbl,*typelbl;



+(instancetype)breakDownDetailCellWithTableView:(UITableView *)tableView;

@end
