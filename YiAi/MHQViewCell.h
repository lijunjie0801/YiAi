//
//  MHQViewCell.h
//  YiAi
//
//  Created by lijunjie on 2017/7/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHQModel.h"
@interface MHQViewCell : UICollectionViewCell
@property (nonatomic, strong) MHQModel *model;
-(void)updateWithModel:(MHQModel *)model;
@property(nonatomic, strong) NSString *indexRow;
@end
