//
//  TableIndexView.h
//  SNYifubao
//
//  Created by GK on 2017/9/30.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableIndexView : UIView
@property (nonatomic,strong) NSMutableArray *indexs;
@property (nonatomic,strong) UITableView *tableView;
- (void)setup;
@end
