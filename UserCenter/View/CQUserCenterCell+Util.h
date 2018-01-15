//
//  CQUserCenterCell+Util.h
//  UserCenter
//
//  Created by 蔡强 on 2018/1/9.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQUserCenterCell.h"

@interface CQUserCenterCell (Util)

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
