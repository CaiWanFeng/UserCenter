//
//  CQUserCenterCell+Util.m
//  UserCenter
//
//  Created by 蔡强 on 2018/1/9.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQUserCenterCell+Util.h"
#import <objc/runtime.h>

typedef void(^DarkModeSwitchHandler)(BOOL);

static void *pointsLabelKey = &pointsLabelKey;
static void *unreadMessageNumLabelKey = &unreadMessageNumLabelKey;
static void *darkModeSwitchKey = &darkModeSwitchKey;
static void *darkModeSwitchHandlerKey = &darkModeSwitchHandlerKey;

@interface CQUserCenterCell ()

/** 积分label */
@property (nonatomic, strong) UILabel *pointsLabel;
/** 未读消息label */
@property (nonatomic, strong) UILabel *unreadMessageNumLabel;
/** 夜间模式switch */
@property (nonatomic, strong) UISwitch *darkModeSwitch;

/** 开启\关闭夜间模式时回调的block */
@property (nonatomic, copy) DarkModeSwitchHandler darkModeSwitchHandler;

@end

@implementation CQUserCenterCell (Util)

- (UILabel *)pointsLabel {
    return objc_getAssociatedObject(self, &pointsLabelKey);
}

- (void)setPointsLabel:(UILabel *)pointsLabel {
    objc_setAssociatedObject(self, &pointsLabelKey, pointsLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)unreadMessageNumLabel {
    return objc_getAssociatedObject(self, &unreadMessageNumLabelKey);
}

- (void)setUnreadMessageNumLabel:(UILabel *)unreadMessageNumLabel {
    objc_setAssociatedObject(self, &unreadMessageNumLabelKey, unreadMessageNumLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UISwitch *)darkModeSwitch {
    return objc_getAssociatedObject(self, &darkModeSwitchKey);
}

- (void)setDarkModeSwitch:(UISwitch *)darkModeSwitch {
    objc_setAssociatedObject(self, &darkModeSwitchKey, darkModeSwitch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DarkModeSwitchHandler)darkModeSwitchHandler {
    return objc_getAssociatedObject(self, &darkModeSwitchHandlerKey);
}

- (void)setDarkModeSwitchHandler:(DarkModeSwitchHandler)darkModeSwitchHandler {
    objc_setAssociatedObject(self, &darkModeSwitchHandlerKey, darkModeSwitchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/** 设置积分数 */
- (void)setPoints:(NSInteger)points {
    if (!self.pointsLabel) {
        self.pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 0, 100, 40)];
        [self.contentView addSubview:self.pointsLabel];
        self.pointsLabel.textColor = [UIColor redColor];
        self.pointsLabel.font = [UIFont systemFontOfSize:14];
    }
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld", points];
}

/** 设置未读消息数量 */
- (void)setUnreadMessageNum:(NSInteger)unreadMessageNum {
    if (!self.unreadMessageNumLabel) {
        self.unreadMessageNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 16, 16)];
        [self.contentView addSubview:self.unreadMessageNumLabel];
        self.unreadMessageNumLabel.backgroundColor = [UIColor redColor];
        self.unreadMessageNumLabel.textColor = [UIColor whiteColor];
        self.unreadMessageNumLabel.font = [UIFont systemFontOfSize:12];
        self.unreadMessageNumLabel.textAlignment = NSTextAlignmentCenter;
        self.unreadMessageNumLabel.layer.cornerRadius = 8;
        self.unreadMessageNumLabel.clipsToBounds = YES;
        self.unreadMessageNumLabel.hidden = YES; // 默认隐藏
    }
    self.unreadMessageNumLabel.text = [NSString stringWithFormat:@"%ld", unreadMessageNum];
}

/** 添加夜间模式switch */
- (void)addNightModeSwitchWithHandler:(void(^)(BOOL isOn))handler {
    // 隐藏cell右边的箭头
    [self hideIndicator];
    
    self.darkModeSwitchHandler = handler;
    
    if (!self.darkModeSwitch) {
        self.darkModeSwitch = [[UISwitch alloc] init];
        [self.contentView addSubview:self.darkModeSwitch];
        self.darkModeSwitch.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 50, 20);
        [self.darkModeSwitch addTarget:self action:@selector(nightSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)nightSwitchValueChanged:(UISwitch *)sender {
    !self.darkModeSwitchHandler ?: self.darkModeSwitchHandler(sender.isOn);
}

@end
