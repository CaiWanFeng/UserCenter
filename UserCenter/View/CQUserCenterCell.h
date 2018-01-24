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

/** 设置积分 */
- (void)setPoints:(NSInteger)points;

/** 设置未读消息数量 */
- (void)setUnreadMessageNum:(NSInteger)unreadMessageNum;

/**
 添加控制夜间模式的switch
 
 @param handler 开启\关闭夜间模式时回调的block
 */
- (void)addNightModeSwitchWithHandler:(void(^)(BOOL isOn))handler;

@end
