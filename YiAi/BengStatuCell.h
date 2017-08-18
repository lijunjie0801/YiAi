//
//  BengStatuCell.h
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BengStatuModel.h"
@interface BengStatuCell : UITableViewCell
@property (nonatomic, strong) UIImageView *statuImg;
@property(nonatomic, strong) UILabel *addressLbl,*remarkLbl,*timeLbl,*statuLbl;
@property (nonatomic, strong)BengStatuModel *model;
+(instancetype)bengStatuCellWithTableView:(UITableView *)tableView;
@end
