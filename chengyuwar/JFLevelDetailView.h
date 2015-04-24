//
//  JFLevelDetailView.h
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFLevelCell.h"
@interface JFLevelDetailView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView   *m_tableView;
    NSMutableArray *m_arrayData;
}

-(void)show;

@end
