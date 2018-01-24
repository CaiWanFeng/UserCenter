//
//  CQUserCenterViewController.m
//  UserCenter
//
//  Created by 蔡强 on 2018/1/8.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQUserCenterViewController.h"
#import "CQUserCenterCell.h"

@interface CQUserCenterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 积分label */
@property (nonatomic, strong) UILabel *pointsLabel;
/** 未读消息 */
@property (nonatomic, strong) UILabel *unreadLabel;
/** 夜间模式开关 */
@property (nonatomic, strong) UISwitch *nightModeSwitch;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *modelArray;

/** 积分cell */
@property (nonatomic, strong) CQUserCenterCell *pointsCell;
/** 未读消息cell */
@property (nonatomic, strong) CQUserCenterCell *unreadCell;
/** 夜间模式cell */
@property (nonatomic, strong) CQUserCenterCell *nightModeCell;

@end

@implementation CQUserCenterViewController

#pragma mark - 懒加载

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
        for (int i = 0; i < 5; i ++) {
            CQUserCenterCellModel *model = [[CQUserCenterCellModel alloc] init];
            switch (i) {
                case 0:
                {
                    model.icon  = @"receiver";
                    model.title = @"收货人管理";
                }
                    break;
                    
                case 1:
                {
                    model.icon  = @"address";
                    model.title = @"收货地址管理";
                }
                    break;
                    
                case 2:
                {
                    model.icon  = @"point";
                    model.title = @"我的积分";
                }
                    break;
                    
                case 3:
                {
                    model.icon  = @"advice";
                    model.title = @"未读消息";
                }
                    break;
                    
                case 4:
                {
                    model.icon  = @"about";
                    model.title = @"夜间模式";
                }
                    break;
                    
                default:
                    break;
            }
            [_modelArray addObject:model];
        }
    }
    return _modelArray;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    
    // 加载数据
    [self loadData];
}

#pragma mark - 加载数据

// 加载数据
- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 设置积分
        [self.pointsCell setPoints:200];
        // 设置未读消息数量
        [self.unreadCell setUnreadMessageNum:3];
    });
}

// 改变主题色
- (void)changeTheme:(BOOL)isNightMode {
    if (isNightMode) {
        self.tableView.backgroundColor = [UIColor grayColor];
    } else {
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - UITableView DataSource & Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 使用唯一复用id
    NSString *reuseCellID = [NSString stringWithFormat:@"%ld_%ld", indexPath.section, indexPath.row];
    CQUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellID];
    if (!cell) {
        cell = [[CQUserCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellID];
        cell.model = self.modelArray[indexPath.row];
        
        switch (indexPath.row) {
            case 2: // 我的积分
            {
                self.pointsCell = cell;
            }
                break;
                
            case 3: // 未读消息
            {
                self.unreadCell = cell;
            }
                break;
                
            case 4: // 夜间模式
            {
                [cell addNightModeSwitchWithHandler:^(BOOL isOn) {
                    [self changeTheme:isOn];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

@end
