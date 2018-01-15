//
//  CQUserCenterCell.m
//  UserCenter
//
//  Created by 蔡强 on 2018/1/8.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQUserCenterCell.h"

@interface CQUserCenterCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation CQUserCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

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

@end
