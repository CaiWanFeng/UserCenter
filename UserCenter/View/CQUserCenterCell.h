//
//  CQUserCenterCell.h
//  UserCenter
//
//  Created by 蔡强 on 2018/1/8.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQUserCenterCellModel.h"

@interface CQUserCenterCell : UITableViewCell

@property (nonatomic, strong) CQUserCenterCellModel *model;

/** 隐藏cell右边的箭头 */
- (void)hideIndicator;

@end
