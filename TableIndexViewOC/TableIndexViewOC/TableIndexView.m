//
//  TableIndexView.m
//  SNYifubao
//
//  Created by GK on 2017/9/30.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "TableIndexView.h"

@implementation TableIndexView

- (void)setup {
    
    [self setExclusiveTouch:YES];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
    NSString *verticalLayoutString = @"V:|";
    
    for (int i = 0; i < self.indexs.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, i * 10, 20, 20)];
        label.text = self.indexs[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addSubview:label];
        NSString *indexString = [NSString stringWithFormat:@"label%d",i];
        [views setObject:label forKey:indexString];
        
        if (i == 0) {
          verticalLayoutString =  [verticalLayoutString stringByAppendingString:[NSString stringWithFormat:@"[%@]",indexString]];;
        }else {
          verticalLayoutString =  [verticalLayoutString stringByAppendingString:[NSString stringWithFormat:@"[%@(==label0)]",indexString]];
        }
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[%@]|",indexString] options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    }
     verticalLayoutString = [verticalLayoutString stringByAppendingString:@"|"];
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalLayoutString options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(indexViewWasDragged:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(indexViewWasDragged:)];
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:pan];
}

- (void)indexViewWasDragged:(UIGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self];
    NSInteger index = MAX(MIN(point.y / self.frame.size.height * self.indexs.count , self.indexs.count - 1), 0);
    CGFloat percentInSection = MAX(point.y / self.frame.size.height * self.indexs.count - index, 0);
    
    [self scrollToIndex:index percentInSection:percentInSection];
}
- (void)scrollToIndex:(NSInteger) index  percentInSection: (CGFloat)percentInSection {
    NSInteger section = index;
    NSInteger rows = [self.tableView numberOfRowsInSection:section];
    NSInteger row = rows * percentInSection;
    NSInteger numberOfSectionsInTable = [self.tableView numberOfSections];
    
//    if (row == 0 && section < numberOfSectionsInTable - 1) {
//        return ;
//    }
    if (rows != 0 && row < rows && section < numberOfSectionsInTable) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:false];
    }

}
@end
