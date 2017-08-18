//
//  TaskBooksCell.h
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFCModel.h"
@interface TaskBooksCell : UITableViewCell

@property(nonatomic, strong) UIButton *typeBtn;
@property(nonatomic, strong) UILabel *titleLbl,*addressLbl,*timeLbl;
@property(nonatomic, strong) UIImageView *headImg;
@property(nonatomic, strong) UILabel *numLbl;
@property(nonatomic, strong) NFCModel *NFCModel;
+(instancetype)taskBooksCellWithTableView:(UITableView *)tableView;

@end
