//
//  CQUserCenterCell.m
//  UserCenter
//
//  Created by 蔡强 on 2018/1/8.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQUserCenterCell.h"

typedef void(^DarkModeSwitchHandler)(BOOL);

@interface CQUserCenterCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

/** 积分label */
@property (nonatomic, strong) UILabel *pointsLabel;
/** 未读消息label */
@property (nonatomic, strong) UILabel *unreadMessageNumLabel;
/** 夜间模式switch */
@property (nonatomic, strong) UISwitch *darkModeSwitch;

/** 开启\关闭夜间模式时回调的block */
@property (nonatomic, copy) DarkModeSwitchHandler darkModeSwitchHandler;

@end

@implementation CQUserCenterCell

#pragma mark - 懒加载

- (UILabel *)pointsLabel {
    if (!_pointsLabel) {
        _pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 0, 100, 40)];
        [self.contentView addSubview:_pointsLabel];
        _pointsLabel.textColor = [UIColor redColor];
        _pointsLabel.font = [UIFont systemFontOfSize:14];
    }
    return _pointsLabel;
}

- (UILabel *)unreadMessageNumLabel {
    if (!_unreadMessageNumLabel) {
        _unreadMessageNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 16, 16)];
        [self.contentView addSubview:_unreadMessageNumLabel];
        _unreadMessageNumLabel.backgroundColor = [UIColor redColor];
        _unreadMessageNumLabel.textColor = [UIColor whiteColor];
        self.unreadMessageNumLabel.font = [UIFont systemFontOfSize:12];
        self.unreadMessageNumLabel.textAlignment = NSTextAlignmentCenter;
        self.unreadMessageNumLabel.layer.cornerRadius = 8;
        self.unreadMessageNumLabel.clipsToBounds = YES;
    }
    return _unreadMessageNumLabel;
}

#pragma mark - 构造方法
/** 构造方法 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建

- (void)setUpUI {
    // 左边图标
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 30, 30)];
    [self.contentView addSubview:self.iconImageView];
    
    // 文本详情
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 40)];
    [self.contentView addSubview:self.titleLabel];
    
    // 右边箭头
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-22, 14.5, 10, 15)];
    [self.contentView addSubview:self.arrowImageView];
    self.arrowImageView.image = [UIImage imageNamed:@"arrow_right"];
}

#pragma mark - 赋值icon和文本

- (void)setModel:(CQUserCenterCellModel *)model {
    _model = model;
    
    // 左边图标
    self.iconImageView.image = [UIImage imageNamed:_model.icon];
    // 文本详情
    self.titleLabel.text = _model.title;
}

/** 隐藏cell右边的箭头 */
- (void)hideIndicator {
    self.arrowImageView.hidden = YES;
}

/** 设置积分数 */
- (void)setPoints:(NSInteger)points {
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld", points];
}

/** 设置未读消息数量 */
- (void)setUnreadMessageNum:(NSInteger)unreadMessageNum {
    self.unreadMessageNumLabel.text = [NSString stringWithFormat:@"%ld", unreadMessageNum];
}

/** 添加夜间模式switch */
- (void)addNightModeSwitchWithHandler:(void(^)(BOOL isOn))handler {
    // 隐藏cell右边的箭头
    [self hideIndicator];
    
    self.darkModeSwitchHandler = handler;
    
    self.darkModeSwitch = [[UISwitch alloc] init];
    [self.contentView addSubview:self.darkModeSwitch];
    self.darkModeSwitch.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 50, 20);
    [self.darkModeSwitch addTarget:self action:@selector(nightSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)nightSwitchValueChanged:(UISwitch *)sender {
    !self.darkModeSwitchHandler ?: self.darkModeSwitchHandler(sender.isOn);
}

@end
